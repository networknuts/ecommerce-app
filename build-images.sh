#!/bin/bash

# Set Docker Hub username and version
REGISTRY="docker.io/aryansr"
VERSION="latest"

# Array of services
services=("gateway" "homepage" "catalog" "cart" "checkout")

# Build and push each service
for service in "${services[@]}"
do
  echo "Building $service..."
  docker build -t ${REGISTRY}/playfair-${service}:${VERSION} ./${service}
  
  echo "Pushing $service..."
  docker push ${REGISTRY}/playfair-${service}:${VERSION}
done

# Build and push PostgreSQL with custom configuration
echo "Building PostgreSQL..."
docker build -t ${REGISTRY}/playfair-postgres:${VERSION} ./postgres
echo "Pushing PostgreSQL..."
docker push ${REGISTRY}/playfair-postgres:${VERSION}