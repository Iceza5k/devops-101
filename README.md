# DevOps 101 Training Repo

This repository is a hands-on starter kit for training new DevOps engineers on a local MacBook Air.

It covers:

- What Docker is
- What Kubernetes is
- How to run a container with Docker
- How to use Docker Compose
- How to build and run a demo application with a `Dockerfile`
- How to deploy the same app to Kubernetes locally

## Training Path

1. Read [Docker Basics](./docs/01-docker.md)
2. Read [Kubernetes Basics](./docs/02-kubernetes.md)
3. Run the demo app locally
4. Build and run it with Docker
5. Run it with Docker Compose
6. Deploy it to local Kubernetes

## Prerequisites

Use a MacBook Air with:

- Docker Desktop installed
- Kubernetes enabled in Docker Desktop
- `kubectl` installed

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
│   └── 02-kubernetes.md
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

## Notes for Trainers

- Start with concepts in `docs/`
- Use the same app across local, Docker, Compose, and Kubernetes
- Keep the workshop focused on workflow, not on application complexity
- Docker Desktop is the simplest local Kubernetes option for Apple Silicon MacBooks
