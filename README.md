# 🚀 Secure Blue–Green CI/CD on AWS EKS

## 📌 Project Overview
This project demonstrates an **end-to-end, production-style DevOps implementation** using **AWS EKS**, **Terraform**, **Docker**, and **GitHub Actions**.  
It implements a **Blue–Green deployment strategy** to achieve **zero-downtime releases**.

The application itself is intentionally simple.  
The focus is on **infrastructure, delivery, rollback safety, automation, and cost control**.

---

## 🎯 Project Goals
- Provision AWS infrastructure using **Terraform**
- Deploy containerized workloads on **Amazon EKS**
- Implement **Blue–Green deployments** with zero downtime
- Automate build and deployment using **GitHub Actions**
- Enable **instant rollback**
- Destroy infrastructure cleanly to **avoid cloud costs**

---

## 🏗️ Architecture Overview

### Core Components
- **Terraform** – Infrastructure as Code (VPC, EKS, IAM, Node Groups)
- **Amazon EKS** – Managed Kubernetes control plane
- **Amazon ECR** – Container image registry
- **Docker** – Application containerization
- **Kubernetes** – Deployment and traffic routing
- **GitHub Actions** – CI/CD automation

### High-Level Flow
1. Terraform provisions AWS infrastructure
2. Application is containerized using Docker
3. Images are pushed to Amazon ECR
4. Blue and Green deployments run in parallel
5. Kubernetes Service controls traffic routing
6. GitHub Actions automates build and deployment
7. Traffic is switched with zero downtime

---

## 📂 Repository Structure

```
.
├── app/
│   ├── app.py
│   └── Dockerfile
│
├── k8s/
│   ├── deployment-blue.yml
│   ├── deployment-green.yml
│   └── service.yml
│
├── eks-blue-green/
│   └── terraform/
│       ├── backend.tf
│       ├── providers.tf
│       ├── versions.tf
│       ├── vpc.tf
│       ├── subnets.tf
│       ├── igw.tf
│       ├── iam-eks.tf
│       ├── node-group.tf
│       └── eks.tf
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── .gitignore
└── README.md
```

---

## 🧩 Application Design
The application is a minimal Flask service used only to demonstrate deployment behavior.

### Endpoints
- **/health** – Health check endpoint  
- **/version** – Returns the active deployment color (`blue` or `green`)

This allows easy validation of traffic routing.

---

## 🐳 Docker Containerization

```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY app.py .
RUN pip install flask
CMD ["python", "app.py"]
```

Images are tagged using deployment colors:
- blue
- green

---

## ☸️ Kubernetes Deployment Strategy

### Blue–Green Model
- Two Deployments run simultaneously
  - app-blue
  - app-green
- Only one Deployment receives traffic
- Traffic routing is handled by the Service

### Why Blue–Green
- Zero downtime
- No pod restarts
- Instant rollback
- Same endpoint and LoadBalancer

---

## 🌐 Kubernetes Service (Traffic Control)

### Service Selector (Blue)
```yaml
selector:
  app: demo
  color: blue
```

### Switch Traffic to Green
```yaml
selector:
  app: demo
  color: green
```

Traffic switches instantly with no restarts.

---

## 🔁 CI/CD Pipeline (GitHub Actions)

### Pipeline Responsibilities
- Build Docker image
- Push image to Amazon ECR
- Deploy inactive version (green)
- Keep traffic switching manual and safe

---

## 🔄 Blue–Green Release Flow
1. Code pushed to main
2. GitHub Actions builds image
3. Image pushed to ECR
4. Green deployment updated
5. Green validated
6. Traffic switched via Service
7. Blue remains for rollback

---

## ⏪ Rollback Strategy

```yaml
color: blue
```

Immediate rollback.
No rebuild.
No redeploy.
No downtime.

---

## 🧱 Infrastructure Provisioning with Terraform

```bash
terraform validate
terraform init
terraform apply
```

### Destroy Everything
```bash
terraform destroy
```

Ensures zero leftover billable resources.

---

## 💰 Cost Management
- Infrastructure is temporary
- Resources destroyed after use
- Prevents unexpected AWS charges

---

## ✅ What This Project Demonstrates
- Infrastructure as Code
- Kubernetes traffic management
- Zero-downtime deployments
- CI/CD automation
- Fast rollback
- Cost discipline

---

## 🔮 Possible Enhancements
- Canary deployments
- Ingress-based routing
- Automated health-gated releases
- Image security scanning
- Monitoring and observability
