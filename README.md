# DevOps 101 Training Repo

This repository is a hands-on starter kit for training new DevOps engineers on a local MacBook Air.

It covers:

- What Docker is
- What Kubernetes is
- How to run a container with Docker
- How to use Docker Compose
- How to build and run a demo application with a `Dockerfile`
- How to deploy the same app to Kubernetes locally
- How to package the app with Helm
- How to deploy it with Argo CD and Argo Rollouts

## Training Path

1. Read [Docker Basics](./docs/01-docker.md)
2. Read [Kubernetes Basics](./docs/02-kubernetes.md)
3. Read [Helm, Argo CD, and Argo Rollouts](./docs/03-helm-argocd.md)
4. Run the demo app locally
5. Build and run it with Docker
6. Run it with Docker Compose
7. Deploy it to local Kubernetes
8. Deploy it with Helm and Argo CD

## Prerequisites

Use a MacBook Air with:

- Docker Desktop installed
- Kubernetes enabled in Docker Desktop
- `kubectl` installed
- `helm` installed
- Argo CD installed in the cluster if you want GitOps deployment
- Argo Rollouts installed in the cluster if you want rollout resources

Check your setup:

```bash
docker --version
docker compose version
kubectl version --client
kubectl config current-context
```

Expected Kubernetes context for Docker Desktop:

```bash
docker-desktop
```

## Repo Structure

```text
.
├── README.md
├── Makefile
├── app
│   ├── package.json
│   └── server.js
├── docker
│   └── nginx.conf
├── docs
│   ├── 01-docker.md
│   ├── 02-kubernetes.md
│   └── 03-helm-argocd.md
├── helm
│   └── demo-app
├── argocd
│   ├── demo-app-application.yaml
│   └── demo-app-rollout-application.yaml
└── k8s
    ├── deployment.yaml
    ├── namespace.yaml
    └── service.yaml
```

## Quick Start

### 1. Run the app directly on your Mac

```bash
cd app
node server.js
```

Open:

```text
http://localhost:3000
```

### 2. Build and run with Docker

```bash
make docker-build
make docker-run
```

Open:

```text
http://localhost:3000
```

### 3. Run with Docker Compose

```bash
make compose-up
```

Open:

```text
http://localhost:8080
```

### 4. Deploy to Kubernetes

Build the image first:

```bash
make docker-build
```

Apply manifests:

```bash
make k8s-apply
```

Port-forward the service:

```bash
kubectl port-forward -n devops-101 svc/demo-app-service 8080:80
```

Open:

```text
http://localhost:8080
```

## Helpful Commands

```bash
make help
```

## Helm Quick Start

Render the default chart:

```bash
helm template demo-app ./helm/demo-app
```

Install with Helm:

```bash
helm upgrade --install demo-app ./helm/demo-app -n devops-101 --create-namespace
```

Render the Argo Rollout version:

```bash
helm template demo-app ./helm/demo-app -f ./helm/demo-app/values-rollout.yaml
```

## Argo CD Quick Start

1. Update `repoURL` in:
   - `argocd/demo-app-application.yaml`
   - `argocd/demo-app-rollout-application.yaml`
2. Apply one of the Argo CD application manifests

Standard deployment mode:

```bash
kubectl apply -f argocd/demo-app-application.yaml
```

Argo Rollouts mode:

```bash
kubectl apply -f argocd/demo-app-rollout-application.yaml
```

## Notes for Trainers

- Start with concepts in `docs/`
- Use the same app across local, Docker, Compose, and Kubernetes
- Keep the workshop focused on workflow, not on application complexity
- Docker Desktop is the simplest local Kubernetes option for Apple Silicon MacBooks
