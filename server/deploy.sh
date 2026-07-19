#!/bin/bash



read -p "Build frontend? (y/n): " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo "==> Building frontend..."
    cd ./frontend
    npm run build
    cd ..
fi

read -p "Build Docker image? (y/n): " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo "==> Building Docker image..."
    docker build . -t mzamarri/dealership:latest
fi

echo "Checking if deployment exist"
if kubectl get deployment dealership > /dev/null 2>&1; then
    echo 'Deployment "dealership" exist'
else
    echo "Deployment does not exist"
    echo "Creating new deployment: dealership"
    kubectl apply -f ./deployment.yaml
    kubectl rollout status deployment dealership
    echo 'Deployment "dealership" created'
fi

read -p "Restart Kubernetes deployment? (y/n)" answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo "==> Restarting Kubernetes deployment..."
    kubectl rollout restart deployment dealership
fi

echo "==> Waiting for Kubernetes rollout..."
kubectl rollout status deployment dealership

echo "==> Port forwarding..."
kubectl port-forward deployment/dealership 8000:8000
