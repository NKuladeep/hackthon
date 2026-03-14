#!/bin/bash

echo "Updating system..."
sudo apt update -y

echo "Installing Java..."
sudo apt install openjdk-17-jdk -y

echo "Installing Maven..."
sudo apt install maven -y

echo "Installing Git..."
sudo apt install git -y

echo "Installing Docker..."
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

echo "Installing kubectl..."
sudo snap install kubectl --classic

echo "Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "Installing Sonar Scanner..."
sudo apt install unzip -y
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip
unzip sonar-scanner-cli-5.0.1.3006-linux.zip
sudo mv sonar-scanner-5.0.1.3006-linux /opt/sonar-scanner

echo "Adding Sonar Scanner to PATH..."
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' >> ~/.bashrc
source ~/.bashrc

echo "Running DevOps tools containers..."

# SonarQube
docker run -d \
--name sonarqube \
-p 9000:9000 \
sonarqube:lts

# Grafana
docker run -d \
--name grafana \
-p 3000:3000 \
grafana/grafana

echo "DevOps environment ready!"