# Trend Application CI/CD on AWS EKS

This repository is set up so you can build the Trend application phase by phase and deploy it to Amazon EKS through Jenkins.

## Current Scope

- Application artifact available in `dist/`
- Docker image build using Nginx
- Jenkins pipeline scaffold for DockerHub and EKS deployment
- Kubernetes manifests for `Deployment` and `LoadBalancer` `Service`
- Minimal Terraform for Jenkins EC2 infrastructure and networking

## Project Structure

```text
.
|-- .dockerignore
|-- .gitignore
|-- Dockerfile
|-- Jenkinsfile
|-- README.md
|-- dist/
|-- kubernetes/
|   |-- deployment.yaml
|   `-- service.yaml
`-- terraform/
    |-- main.tf
    |-- outputs.tf
    |-- terraform.tfvars
    `-- variables.tf
```

## Suggested Phase Order

1. Verify the app locally from `dist/`
2. Build and test the Docker image
3. Push the image to DockerHub
4. Provision the Jenkins EC2 infrastructure with Terraform
5. Install and configure Jenkins on the EC2 instance
6. Create the EKS cluster
7. Apply the Kubernetes manifests
8. Configure Jenkins credentials and run the pipeline
9. Add the GitHub webhook

## Docker Build

```bash
docker build -t your-dockerhub-username/trend-app:latest .
docker run -d -p 80:80 your-dockerhub-username/trend-app:latest
```

## Kubernetes Deploy

Update the image name in `kubernetes/deployment.yaml`, then apply:

```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

## Jenkins Setup Notes

Before using the pipeline, configure these in Jenkins:

- DockerHub credentials
- GitHub repository access if needed
- AWS credentials with EKS access
- `kubectl` configured on the Jenkins server

## Terraform Notes

The Terraform configuration provisions:

- VPC
- 2 public subnets
- Internet gateway and route table
- Security group for Jenkins
- IAM role and instance profile for EC2
- Jenkins EC2 instance

Update `terraform/terraform.tfvars` before applying.
Webhook Test
