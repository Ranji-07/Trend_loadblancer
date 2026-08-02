# End-to-End DevOps CI/CD Pipeline on AWS EKS

## Project Overview

This project demonstrates a complete DevOps CI/CD pipeline by deploying a containerized web application on Amazon EKS using Jenkins, Docker, Terraform, GitHub, Kubernetes, Prometheus, and Grafana.

The workflow automates infrastructure provisioning, application packaging, Docker image publishing, Kubernetes deployment, and monitoring.

## Project Architecture

```text
GitHub
        |
        v
GitHub Webhook
        |
        v
Jenkins Pipeline
        |
        |---------------> Docker Build
        |                     |
        |                     v
        |              DockerHub Repository
        |                     |
        v                     v
Terraform -------------> Amazon EKS Cluster
                              |
                              v
                     Kubernetes Deployment
                              |
                              v
                        LoadBalancer Service
                              |
                              v
                           End Users

                     Monitoring Stack
              Prometheus + Grafana Dashboard
```

## Tech Stack

- AWS EC2
- AWS IAM
- AWS VPC
- AWS EKS
- Terraform
- Docker
- DockerHub
- Jenkins
- GitHub
- Kubernetes
- kubectl
- Helm
- Prometheus
- Grafana

## Project Workflow

1. Developer pushes code to GitHub.
2. GitHub Webhook triggers the Jenkins pipeline.
3. Jenkins pulls the latest source code.
4. Docker image is built.
5. Docker image is pushed to DockerHub.
6. Jenkins updates the Kubernetes Deployment.
7. Amazon EKS pulls the latest Docker image.
8. The application is exposed using a LoadBalancer Service.
9. Prometheus collects cluster metrics.
10. Grafana visualizes dashboards.

## Repository Structure

```text
Trend_loadblancer/
|
|-- Dockerfile
|-- Jenkinsfile
|-- README.md
|-- .gitignore
|-- .dockerignore
|
|-- kubernetes/
|   |-- namespace.yaml
|   |-- deployment.yaml
|   `-- service.yaml
|
|-- terraform/
|   |-- main.tf
|   |-- variables.tf
|   |-- outputs.tf
|   `-- terraform.tfvars
|
|-- dist/
|
`-- screenshots/
```

## Docker

```bash
docker build -t ranjith02987/trend-app:latest .
docker run -d -p 3000:80 ranjith02987/trend-app:latest
```

## Kubernetes

```bash
kubectl apply -f kubernetes/
kubectl get all -n trend
```

## Jenkins Pipeline

Pipeline stages:

- Checkout Source
- Validate Files
- Build Docker Image
- Push DockerHub Image
- Deploy to Amazon EKS
- Verify Deployment

## Monitoring

Monitoring stack:

- Prometheus
- Grafana

Features:

- Cluster Monitoring
- Node Monitoring
- Pod Monitoring
- CPU Usage
- Memory Usage
- Network Usage

## Screenshots

Include screenshots for:

- Jenkins Pipeline Success
- DockerHub Repository
- EKS Cluster
- `kubectl` Output
- Application
- Grafana Dashboard
- Prometheus Targets

## Architecture Diagram Prompt

Use this prompt in ChatGPT Image Generation, DALL-E, Microsoft Designer, Canva AI, Napkin AI, or Eraser AI:

```text
Create a professional AWS DevOps architecture diagram with a white background.

The architecture should include:

Developer
↓
GitHub Repository
↓
GitHub Webhook
↓
Jenkins Server running on AWS EC2
↓
Pipeline Stages:
- Checkout Source Code
- Build Docker Image
- Push Docker Image to DockerHub
- Deploy to Amazon EKS

DockerHub Repository connected to Jenkins.

Terraform provisions:
- VPC
- IAM Roles
- EC2
- Amazon EKS Cluster

Amazon EKS Cluster contains:
- Namespace
- Deployment
- Pods
- Service (LoadBalancer)

Users access the application through AWS Elastic LoadBalancer.

Monitoring Stack:
- Prometheus collects Kubernetes metrics
- Grafana visualizes dashboards

Use official AWS icons, Docker, Kubernetes, Jenkins, GitHub, Prometheus, and Grafana logos.

Use arrows to clearly represent the deployment flow.

Style:
Professional AWS architecture diagram suitable for GitHub README and LinkedIn.
```

## Architecture Diagram Nodes

Use these nodes when recreating the diagram in Visio, Draw.io, Lucidchart, or similar tools:

- Developer
- GitHub
- GitHub Webhook
- Jenkins (AWS EC2)
- Checkout Code
- Docker Build
- DockerHub
- Terraform
- Amazon EKS
- Deployment
- Pods
- Service (LoadBalancer)
- Application
- Prometheus
- Grafana
- Monitoring Dashboard

## Author

Ranjith
