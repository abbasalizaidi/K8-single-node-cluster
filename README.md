# Kubernetes single node Cluster Setup

This repo hosts the code to provision single node Kubernetes cluster in AWS using Terraform (IAC) in single terraform apply. 

Note: Ansible proivisioner for terraform is still under consideration and not supported formally by Terraform. This is using terrform provisioners namely remote-exec and local-exec.


# Prerequisites ( Should be setup on local machine)
  - Ansible ( Follow this link https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html )
  - Git ( Follow this link https://gist.github.com/derhuerst/1b15ff4652a867391f03 )
  - Terraform ( Follow this link https://www.terraform.io/downloads.html )
  

# Steps
  - Setup the tools mentioned in Prerequisites.
  - Clone the repo to your local machine.
  - Change the variables.tf  ( AWS account key and AWS secret Key and other accordingly).
  - Run command to initialize terraform
   
    - ```terraform init``` 
    - ``` terraform plan``` (just a verification step)
    - ``` terraform apply```
  
  - Wait for terraform to provision the infrastructure for running kubernetes cluster.
  - Once terraform completes, it will provide you a public IP ( Note it down )
  - Setup Kubectl on your local machince
    Mac users
    - ``` brew install kubectl```
  - Edit $HOME/.kube/config
    Change x.x.x.x to the public IP (Noted above)
    - ```server: https://x.x.x.x:6443```
  - Try command 
    - "$ kubectl --insecure-skip-tls-verify=true get nodes"
    
    
   Boom! You have single node K8 cluster ready.
