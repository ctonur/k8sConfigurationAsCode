# Introduction

The leading open source automation server, Jenkins provides hundreds of plugins to support building, deploying and automating any project.
# Components:
## Simple Webapp:

A Basic flask python web applicaton has been developed in order to match the requirements. 

## Build the Webapp Container.

### Create K8s Cluster on GCP by Using Terraform
```
#!/bin/bash

# Create Kubernetes Cluster on GCP with Terraform

service_account_name = terraform
project_name = case-study-22


# Terraform Installation:

wget https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip
unzip terraform_0.12.6_linux_amd64.zip
sudo mv terraform /opt/terraform
sudo ln -s /opt/terraform /usr/local/bin/terraform

# GCP Environment Settings:

### Required a project on GCP created first.

echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk kubectl
gcloud init

gcloud services enable compute.googleapis.com
gcloud services enable servicenetworking.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable container.googleapis.com

# Service Account create in order to run Terraform:

gcloud iam service-accounts create $service_account_name

###	Providing Roles:

gcloud projects add-iam-policy-binding $project_name --member serviceAccount:$service_account_name@$project_name.iam.gserviceaccount.com --role roles/container.admin
gcloud projects add-iam-policy-binding $project_name --member serviceAccount:$service_account_name@$project_name.iam.gserviceaccount.com --role roles/compute.admin
gcloud projects add-iam-policy-binding $project_name --member serviceAccount:$service_account_name@$project_name.iam.gserviceaccount.com --role roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding $project_name --member serviceAccount:$service_account_name@$project_name.iam.gserviceaccount.com --role roles/resourcemanager.projectIamAdmin

# Create Kubernetes Cluster:

terraform init
terraform plan
terraform apply -auto-approve


###	Key create for service account for credentials:


gcloud container clusters get-credentials <cluster-name> --zone = <your_zone>

gcloud iam service-accounts keys create service_account.json --iam-account=$service_account_name@$project_name.iam.gserviceaccount.com


```

### Configuration as Code of Jenkins on K8s

```
Generate an ssh-keypair for github_id_rsa and gcluod auth. 

Put the private key in the resources-folder and use it when runnin the advanced jcasc examples or creating Jenkins with Helm.

k8s

Files for running our Jenkins in K8s

resources

Common configuration-files used by the examples

Run install script to install jenkins by configuration and call pipeline for docker build, test and deploy

```

## K8s autoscale:

```
Next step is ingress creation after creating application deployment and its related service on Kubernetes cluster. 

        kubectl apply -f ingress.yaml

Next step is horizontal pod autoscaler creation. Ingress forwarding-rule will be used to create external metrics for http/https metrics:

        kubectl apply -f hpa.yaml
```

