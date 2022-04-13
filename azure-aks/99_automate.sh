#!/bin/bash
echo "==================================Start Terraform Initialzation========================================="
terraform init -input=false
echo "====================================Start Validate Terraform============================================"
terraform validate
echo "====================================Start Terraform Planning============================================"
terraform plan -out=tfplan -input=false
echo "=====================================Start Terraform Apply=============================================="
terraform apply -input=false tfplan
echo "================================Finished Automate Terraform Process====================================="