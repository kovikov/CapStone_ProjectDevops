# Zuri Market DevOps Capstone

This repository contains a full-stack project for a devops capstone, including:
- `backend/` - Node.js Express API
- `frontend/` - React + Vite web client
- `docker-compose.yml` - local service orchestration
- `.github/workflows/ci-cd.yml` - GitHub Actions build and Docker publish workflow
- `kubernetes/` and `terraform/` folders for future deployment infrastructure

## DockerHub Images
- `renefondufe/zuri-backend:latest`
- `renefondufe/zuri-frontend:latest`

## Local development

### Backend
```bash
cd backend
npm install
npm run dev
```

### Frontend
```bash
cd frontend
npm install
npm run dev
```

### Full stack with Docker Compose
```bash
docker compose up --build
```
Then browse to `http://localhost:3000`.

## GitHub Actions CI/CD
The CI/CD workflow runs on `main` pushes and pull requests.
It performs:
- backend install and test
- frontend install and build
- Docker image build and push to DockerHub

### Required repository secrets
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`

## Kubernetes deployment
The `kubernetes/` directory includes:
- `namespace.yaml`
- `backend-deployment.yaml`
- `backend-service.yaml`
- `frontend-deployment.yaml`
- `frontend-service.yaml`
- `ingress.yaml`

Deploy to Kubernetes with:
```bash
kubectl apply -f kubernetes/
```

## Terraform infrastructure
The `terraform/` directory includes a simple AWS VPC and EC2 bootstrap setup for k3s deployment.
The EC2 instance user data will install k3s, clone this GitHub repository, and apply the Kubernetes manifests from `kubernetes/`.

### Initialize and apply
```bash
cd terraform
terraform init
terraform apply
```

### After apply
Terraform outputs include the public IP of the EC2 instance.
You can use that IP to verify the k3s node and then access the deployed frontend through your cluster ingress.

## Notes
- The frontend is served by NGINX in production.
- The backend uses Express and supports `/api/products` and `/api/config`.
- The repo is initialized and linked to `https://github.com/kovikov/CapStone_ProjectDevops.git`.
