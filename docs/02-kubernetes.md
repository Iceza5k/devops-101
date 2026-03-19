# Kubernetes Basics

## What Is Kubernetes?

Kubernetes, often called `K8s`, is a platform for running and managing containers at scale.

Why teams use Kubernetes:

- It schedules containers onto machines
- It restarts failed workloads
- It supports scaling applications
- It helps manage networking and service discovery
- It supports rolling updates

## Important Terms

- `Pod`: The smallest deployable unit in Kubernetes
- `Deployment`: Manages pod replicas and updates
- `Service`: Gives stable network access to pods
- `Namespace`: Separates resources logically
- `kubectl`: Command-line tool to manage a cluster

## Local Kubernetes on a MacBook Air

For local training, use Docker Desktop Kubernetes.

Enable it in Docker Desktop:

1. Open Docker Desktop
2. Go to Settings
3. Open Kubernetes
4. Enable Kubernetes
5. Wait until the cluster is ready

Verify:

```bash
kubectl config current-context
kubectl get nodes
```

Expected context:

```text
docker-desktop
```

## Deploy the Demo App

First build the image locally:

```bash
docker build -t devops101/demo-app:1.0.0 .
```

Then apply Kubernetes manifests:

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

Or:

```bash
make k8s-apply
```

## Check the Deployment

```bash
kubectl get all -n devops-101
kubectl describe deployment demo-app -n devops-101
kubectl logs -n devops-101 deployment/demo-app
```

## Access the App

This repository uses a `ClusterIP` service to keep the setup simple and portable.

Use port-forward:

```bash
kubectl port-forward -n devops-101 svc/demo-app-service 8080:80
```

Then test:

```bash
curl http://localhost:8080
curl http://localhost:8080/health
```

## Kubernetes Manifest Explanation

### Namespace

Creates an isolated training space called `devops-101`.

### Deployment

- Runs 2 replicas of the app
- Uses the local image `devops101/demo-app:1.0.0`
- Exposes container port `3000`
- Includes readiness and liveness probes

### Service

- Selects the app pods
- Exposes port `80`
- Sends traffic to container port `3000`

## Clean Up

```bash
make k8s-delete
```

Or:

```bash
kubectl delete -f k8s/service.yaml
kubectl delete -f k8s/deployment.yaml
kubectl delete -f k8s/namespace.yaml
```

## What New DevOps Engineers Should Learn Here

- How Kubernetes differs from Docker
- How Deployments manage pods
- How Services expose applications
- How health probes work
- How to inspect running workloads with `kubectl`
