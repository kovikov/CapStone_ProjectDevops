#!/bin/bash
set -e

# Install dependencies for cloning the repository
if command -v yum >/dev/null 2>&1; then
  yum update -y
  yum install -y git
elif command -v apt-get >/dev/null 2>&1; then
  apt-get update
  apt-get install -y git
fi

# Install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="v1.29.5+k3s1" sh -

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Wait for k3s to become available
until kubectl get nodes >/dev/null 2>&1; do
  sleep 5
done

# Clone the project repo and apply Kubernetes manifests
cd /home/ec2-user
if [ ! -d "CapStone_ProjectDevops" ]; then
  git clone https://github.com/kovikov/CapStone_ProjectDevops.git
fi
cd CapStone_ProjectDevops/kubernetes
kubectl apply -f .
