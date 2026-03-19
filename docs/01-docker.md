# Docker Basics

## What Is Docker?

Docker is a tool for packaging an application and its runtime dependencies into a container image.

Why teams use Docker:

- The same app runs the same way on different machines
- Developers avoid "works on my machine" problems
- It is easy to ship the app to testing, staging, and production
- Containers start quickly and use fewer resources than full virtual machines

## Important Terms

- `Image`: A packaged template for an application
- `Container`: A running instance of an image
- `Dockerfile`: Instructions for building an image
- `Docker Compose`: A tool for running multiple containers together

## Docker Workflow

1. Write your application
2. Create a `Dockerfile`
3. Build an image
4. Run a container
5. Stop and remove the container

## Run the Demo App Without Docker

```bash
cd app
node server.js
```

Test it:

```bash
curl http://localhost:3000
curl http://localhost:3000/health
```

## Build the Docker Image

From the repository root:

```bash
docker build -t devops101/demo-app:1.0.0 .
```

Or:

```bash
make docker-build
```

## Run a Docker Container

```bash
docker run --rm -d --name devops101-demo-app -p 3000:3000 devops101/demo-app:1.0.0
```

Check it:

```bash
docker ps
curl http://localhost:3000
curl http://localhost:3000/health
```

View logs:

```bash
docker logs devops101-demo-app
```

Stop it:

```bash
docker stop devops101-demo-app
```

## Dockerfile Explanation

File: `Dockerfile`

- `FROM node:20-alpine`: Start from a lightweight Node.js image
- `WORKDIR /usr/src/app`: Set the working directory
- `COPY ...`: Copy application files into the image
- `EXPOSE 3000`: Document the application port
- `CMD ["node", "server.js"]`: Start the application

## Docker Compose

Docker Compose is used when you want to run more than one container together.

In this repository:

- `app`: The Node.js demo application
- `nginx`: A reverse proxy in front of the app

Start everything:

```bash
docker compose up --build -d
```

Or:

```bash
make compose-up
```

Check services:

```bash
docker compose ps
```

Test it:

```bash
curl http://localhost:8080
curl http://localhost:8080/health
```

Stop everything:

```bash
docker compose down
```

Or:

```bash
make compose-down
```

## What New DevOps Engineers Should Learn Here

- How an image is built
- How a container maps ports
- How logs are read
- How multiple services can run together
- How the same app can move from local machine to orchestration platforms
