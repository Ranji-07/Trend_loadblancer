pipeline {
    agent any

    environment {
        APP_NAME = "trend-app"
        CONTAINER_NAME = "trend-container"
        IMAGE_REPO = "ranjith02987/trend-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_LATEST = "${IMAGE_REPO}:latest"
        IMAGE_VERSIONED = "${IMAGE_REPO}:${IMAGE_TAG}"
        KUBE_NAMESPACE = "trend"
        EKS_CLUSTER_NAME = "trend-cluster"
        AWS_DEFAULT_REGION = "eu-north-1"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Validate Project Files') {
            steps {
                sh '''
                    set -e
                    test -f Dockerfile
                    test -d dist
                    test -f kubernetes/namespace.yaml
                    test -f kubernetes/deployment.yaml
                    test -f kubernetes/service.yaml
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    set -e
                    docker build -t "${IMAGE_VERSIONED}" -t "${IMAGE_LATEST}" .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    sh '''
                        set -e
                        echo "${DOCKERHUB_PASS}" | docker login -u "${DOCKERHUB_USER}" --password-stdin
                        docker push "${IMAGE_VERSIONED}"
                        docker push "${IMAGE_LATEST}"
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    sh '''
                        set -e
                        aws eks update-kubeconfig --region "${AWS_DEFAULT_REGION}" --name "${EKS_CLUSTER_NAME}"
                        kubectl apply -f kubernetes/namespace.yaml
                        kubectl apply -f kubernetes/deployment.yaml
                        kubectl apply -f kubernetes/service.yaml
                        kubectl set image deployment/"${APP_NAME}" "${CONTAINER_NAME}"="${IMAGE_VERSIONED}" -n "${KUBE_NAMESPACE}"
                        kubectl rollout status deployment/"${APP_NAME}" -n "${KUBE_NAMESPACE}" --timeout=180s
                        kubectl get pods -n "${KUBE_NAMESPACE}"
                        kubectl get svc -n "${KUBE_NAMESPACE}"
                    '''
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                    kubectl get deployment -n trend
                    kubectl get pods -n trend
                    kubectl get svc -n trend
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully."
        }

        failure {
            echo "Pipeline failed. Check the console output."
        }

        always {
            sh 'docker logout || true'
        }
    }
}
