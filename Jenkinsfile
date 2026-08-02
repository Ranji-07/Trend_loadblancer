pipeline {
    agent any

    environment {
        APP_NAME = "trend-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKER_IMAGE = "your-dockerhub-username/trend-app:${IMAGE_TAG}"
        KUBE_NAMESPACE = "default"
        EKS_CLUSTER_NAME = "your-eks-cluster-name"
        AWS_DEFAULT_REGION = "ap-south-1"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE% .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS'
                )]) {
                    bat 'echo %DOCKERHUB_PASS% | docker login -u %DOCKERHUB_USER% --password-stdin'
                    bat 'docker push %DOCKER_IMAGE%'
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    bat 'aws eks update-kubeconfig --region %AWS_DEFAULT_REGION% --name %EKS_CLUSTER_NAME%'
                    bat 'kubectl set image deployment/%APP_NAME% %APP_NAME%=%DOCKER_IMAGE% -n %KUBE_NAMESPACE% || kubectl apply -f kubernetes/deployment.yaml'
                    bat 'kubectl apply -f kubernetes/service.yaml'
                }
            }
        }
    }
}
