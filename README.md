# Playfair E-Commerce Platform

A modern, microservices-based e-commerce platform built with Node.js, React, and Kubernetes.

## Architecture Overview

The platform consists of the following microservices:

- **Gateway Service** (Port 3000): API Gateway that routes requests to appropriate services
- **Homepage Service** (Port 3001): Handles the main shopping interface
- **Catalog Service** (Port 3002): Manages product catalog and categories
- **Cart Service** (Port 3003): Handles shopping cart operations
- **Checkout Service** (Port 3004): Manages order processing and checkout
- **PostgreSQL Database**: Persistent storage for all services

## Prerequisites

- Docker
- Kubernetes cluster (local or cloud)
- kubectl CLI
- Node.js 20.x
- npm 10.x

## Local Development

1. Install dependencies for each service:
```bash
cd gateway && npm install
cd ../homepage && npm install
cd ../catalog && npm install
cd ../cart && npm install
cd ../checkout && npm install
```

2. Set up environment variables:
```bash
cp .env.example .env
```

3. Start the development servers:
```bash
# In separate terminals
cd gateway && npm run dev
cd homepage && npm run dev
cd catalog && npm run dev
cd cart && npm run dev
cd checkout && npm run dev
```

## Building and Deploying

### 1. Build and Push Docker Images

Make the build script executable and run it:
```bash
chmod +x build-images.sh
./build-images.sh
```

This will build and push all service images to Docker Hub under the `aryansr` namespace.

### 2. Deploy to Kubernetes

1. Create the namespace:
```bash
kubectl apply -f k8s/namespace.yaml
```

2. Create storage resources:
```bash
# Update the node name in k8s/local-pv.yaml first!
kubectl apply -f k8s/storage-class.yaml
kubectl apply -f k8s/local-pv.yaml
```

3. Create ConfigMap and Secrets:
```bash
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml
```

4. Deploy all services:
```bash
kubectl apply -f k8s/
```

### 3. Verify Deployment

Check the status of all pods:
```bash
kubectl get pods -n playfair
```

Check services:
```bash
kubectl get services -n playfair
```

## Database Schema

The platform uses PostgreSQL with the following main tables:

- **categories**: Product categories
- **products**: Product information
- **cart_items**: Shopping cart items
- **orders**: Customer orders
- **order_items**: Items within orders

## Monitoring

The platform includes:
- Kubernetes metrics server for basic monitoring
- Liveness probes for service health checks
- Resource limits and requests for all pods

## Security

- Row Level Security (RLS) enabled for all database tables
- Secure communication between services
- Environment variables for sensitive data
- Kubernetes secrets for credentials

## Directory Structure

```
.
├── gateway/           # API Gateway service
├── homepage/          # Homepage service
├── catalog/           # Catalog service
├── cart/             # Cart service
├── checkout/         # Checkout service
├── postgres/         # PostgreSQL configuration
├── k8s/              # Kubernetes manifests
├── supabase/         # Database migrations
└── build-images.sh   # Docker build script
```

## Environment Variables

Required environment variables:

```
POSTGRES_USER=playfair
POSTGRES_PASSWORD=your_password
POSTGRES_DB=playfair
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

MIT License - See LICENSE file for details
