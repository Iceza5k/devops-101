.PHONY: help docker-build docker-run docker-stop compose-up compose-down k8s-apply k8s-delete k8s-port-forward

IMAGE_NAME=devops101/demo-app:1.0.0
CONTAINER_NAME=devops101-demo-app

help:
	@echo "Available commands:"
	@echo "  make docker-build       Build the Docker image"
	@echo "  make docker-run         Run the Docker container on port 3000"
	@echo "  make docker-stop        Stop and remove the Docker container"
	@echo "  make compose-up         Start Docker Compose services"
	@echo "  make compose-down       Stop Docker Compose services"
	@echo "  make k8s-apply          Apply Kubernetes manifests"
	@echo "  make k8s-delete         Delete Kubernetes manifests"
	@echo "  make k8s-port-forward   Forward Kubernetes service to localhost:8080"

docker-build:
	docker build -t $(IMAGE_NAME) .

docker-run:
	docker run --rm -d --name $(CONTAINER_NAME) -p 3000:3000 $(IMAGE_NAME)

docker-stop:
	docker stop $(CONTAINER_NAME)

compose-up:
	docker compose up --build -d

compose-down:
	docker compose down

k8s-apply:
	kubectl apply -f k8s/namespace.yaml
	kubectl apply -f k8s/deployment.yaml
	kubectl apply -f k8s/service.yaml

k8s-delete:
	kubectl delete -f k8s/service.yaml --ignore-not-found
	kubectl delete -f k8s/deployment.yaml --ignore-not-found
	kubectl delete -f k8s/namespace.yaml --ignore-not-found

k8s-port-forward:
	kubectl port-forward -n devops-101 svc/demo-app-service 8080:80
