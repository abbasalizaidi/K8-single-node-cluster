# Kubernetes single node Cluster Setup

This repo hosts the code to provision single node Kubernetes cluster in AWS using Terraform (IAC) in single hit of terraform apply. 

## Resources this code creates
  - VPC
  - Subnet
  - Internet Gateway
  - Route Tables
  - Elastic IP
  - Security Groups
  - EC2 Instance
  - KeyPair

# Prerequisites ( Should be setup on local machine)
  - AWS account credentials
  - Ansible ( Follow this link https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html )
  - Git ( Follow this link https://gist.github.com/derhuerst/1b15ff4652a867391f03 )
  - Terraform ( Follow this link https://www.terraform.io/downloads.html )
  
### Versions:

  - Ubuntu 16.04
  - Kubectl 1.14
  - Terraform v0.11.13
  - Ansible 2.7.6
  
# Steps
  - Setup the tools mentioned in Prerequisites.
  - Clone the repo to your local machine.
  - Change the variables.tf  ( AWS account key and AWS secret Key and other accordingly).
  - Create a public and private key using ssh-keygen command and provide a reference in security.tf accordingly. 
    (Keep the name as kube_key to avoid making changes to the code and keep the private key safe)
    
  - Run command to initialize terraform
   
    - ``` terraform init``` 
    - ``` terraform plan``` (just a verification step)
    - ``` terraform apply```
  
  - Wait for terraform to provision the infrastructure for running kubernetes cluster.
  - Once terraform completes, it will provide you a public IP ( Note it down )
  - Setup Kubectl on your local machince
    Mac users
    - ``` brew install kubectl```
  - Edit $HOME/.kube/config
    Change x.x.x.x to the public IP of the provisioned instance (Noted above)
    - ```server: https://x.x.x.x:6443```
  - Try command 
    - "$ kubectl --insecure-skip-tls-verify=true get nodes"
    

   ## Boom! You have single node K8 cluster ready.

Note: Ansible proivisioner for terraform is still under consideration and not supported formally by Terraform. This code is using terraform provisioners namely remote-exec and local-exec running ansible playbook remotely.
