# Playfair E-Commerce Platform

A modern, microservices-based e-commerce platform built with Node.js, React, and OpenShift.

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
- OpenShift cluster (local or cloud)
- oc CLI
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

### 2. Deploy to OpenShift

1. Login to your OpenShift cluster:
```bash
oc login --token=<your-token> --server=<your-server>
```

2. Create the project (namespace):
```bash
oc new-project playfair
```

3. Create storage resources:
```bash
# Create PersistentVolume and StorageClass
oc apply -f k8s/storage-class.yaml
oc apply -f k8s/local-pv.yaml
```

4. Create ConfigMap and Secrets:
```bash
oc create configmap playfair-config --from-file=k8s/configmap.yaml
oc create secret generic playfair-secret --from-file=k8s/secret.yaml
```

5. Deploy all services:
```bash
oc apply -f k8s/
```

6. Create routes for external access:
```bash
oc expose service gateway
```

### 3. Verify Deployment

Check the status of all pods:
```bash
oc get pods -n playfair
```

Check routes and services:
```bash
oc get routes -n playfair
oc get services -n playfair
```

View deployment status:
```bash
oc status
```

Scale deployments if needed:
```bash
oc scale deployment/gateway --replicas=3
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
- OpenShift monitoring and metrics
- Liveness probes for service health checks
- Resource limits and requests for all pods
- Integration with OpenShift's built-in monitoring stack

## Security

- Row Level Security (RLS) enabled for all database tables
- Secure communication between services using OpenShift's internal network
- Environment variables for sensitive data
- OpenShift secrets for credentials
- RBAC policies for access control

## Directory Structure

```
.
├── gateway/           # API Gateway service
├── homepage/          # Homepage service
├── catalog/           # Catalog service
├── cart/             # Cart service
├── checkout/         # Checkout service
├── postgres/         # PostgreSQL configuration
├── k8s/              # OpenShift/Kubernetes manifests
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
