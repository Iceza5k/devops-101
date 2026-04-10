# Helm, Argo CD, and Argo Rollouts

## Why Add Helm?

Helm lets you package Kubernetes manifests as a reusable chart with configurable values.

For this repository, Helm gives you:

- One chart for the demo app
- Configurable image name and tag
- Configurable replica count and service settings
- A switch to render either a normal `Deployment` or an Argo `Rollout`

## Helm Chart Layout

```text
helm/demo-app
├── Chart.yaml
├── values.yaml
├── values-rollout.yaml
└── templates
    ├── _helpers.tpl
    ├── deployment.yaml
    ├── rollout.yaml
    └── service.yaml
```

## Render the Default Deployment

```bash
helm template demo-app ./helm/demo-app
```

Install it:

```bash
helm upgrade --install demo-app ./helm/demo-app -n devops-101 --create-namespace
```

## Render the Argo Rollout Version

```bash
helm template demo-app ./helm/demo-app -f ./helm/demo-app/values-rollout.yaml
```

Install it:

```bash
helm upgrade --install demo-app ./helm/demo-app \
  -n devops-101 \
  --create-namespace \
  -f ./helm/demo-app/values-rollout.yaml
```

Important:

- This requires Argo Rollouts CRDs and controller to already exist in the cluster
- If Argo Rollouts is not installed, the `Rollout` resource will fail to apply
- The included rollout uses a simple replica-based canary strategy, which is easier for local training than full traffic-routing

## Values You Will Usually Change

File: `helm/demo-app/values.yaml`

- `image.repository`
- `image.tag`
- `replicaCount`
- `env.appMessage`
- `service.type`
- `rollout.enabled`

Example override:

```yaml
image:
  repository: ghcr.io/your-org/devops101-demo-app
  tag: "1.0.3"

env:
  appMessage: "Hello from production"

replicaCount: 3
```

## Argo CD Applications

This repository includes:

- `argocd/demo-app-application.yaml`: Argo CD app using standard Helm deployment mode
- `argocd/demo-app-rollout-application.yaml`: Argo CD app using Argo Rollouts mode

Before applying them, update:

- `spec.source.repoURL`

Replace this placeholder:

```text
https://github.com/your-org/devops-101.git
```

With your real Git repository URL.

## Apply Argo CD Application

Standard Helm deployment:

```bash
kubectl apply -f argocd/demo-app-application.yaml
```

Argo Rollouts deployment:

```bash
kubectl apply -f argocd/demo-app-rollout-application.yaml
```

## Observe Rollout Status

```bash
kubectl get rollout -n devops-101
kubectl describe rollout demo-app-demo-app -n devops-101
kubectl argo rollouts get rollout demo-app-demo-app -n devops-101
```

The default rendered resource name is:

```text
demo-app-demo-app
```

That comes from:

- Release name: `demo-app`
- Chart name: `demo-app`

If you want a shorter name, set:

```yaml
fullnameOverride: demo-app
```
