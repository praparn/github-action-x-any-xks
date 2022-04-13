#!/bin/bash
today=`date '+%Y_%m_%d__%H_%M_%S'`;
filename="./log/Result_$today.log"
clear
echo "Please kindly export your access_key/secret_key to environment variable before use this script"
echo "======================================================================================================="
echo "export ARM_CLIENT_ID=00000000-0000-0000-0000-000000000000"                                           
echo "export ARM_CLIENT_SECRET=00000000-0000-0000-0000-000000000000"
echo "export ARM_SUBSCRIPTION_ID=00000000-0000-0000-0000-000000000000"
echo "export ARM_TENANT_ID=00000000-0000-0000-0000-000000000000"
echo "======================================================================================================="
echo "Your current environment variable now:"
echo "======================================================================================================="
echo "ARM_CLIENT_ID:"
echo $ARM_CLIENT_ID
echo "ARM_CLIENT_SECRET:"
echo $ARM_CLIENT_SECRET
echo "ARM_SUBSCRIPTION_ID:"
echo $ARM_SUBSCRIPTION_ID
echo "ARM_TENANT_ID:"
echo $ARM_TENANT_ID
echo "======================================================================================================="
echo "Please input 'Yes'. If you already check and confirm the environment variable."
echo "======================================================================================================="
echo "Remark: In case for enhance Kubelet Engine and Network Configuration. Please enable the preview feature 'microsoft.ContainerService/CustomNodeConfigPreview'"
echo "======================================================================================================="
read answer
if [ "${answer}" ]; then
if [ "${answer}" != 'Yes' ]; then
exit
fi
else
exit
fi
echo "====================================Finished to Set Credential=========================================="
echo "====================================Start to SetUp Variable============================================="
export TF_VAR_ARM_CLIENT_ID=$ARM_CLIENT_ID
export TF_VAR_ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET
export TF_VAR_ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID
export TF_VAR_ARM_TENANT_ID=$ARM_TENANT_ID
if [ -z "$ARM_CLIENT_ID" ] || [ -z "$ARM_CLIENT_SECRET" ] || [ -z "$ARM_SUBSCRIPTION_ID" ] || [ -z "$ARM_TENANT_ID" ]
then
echo "======================================================================================================="
echo "The setup environment variable is invalid!!!. Please check again."
echo "======================================================================================================="
echo "ARM_CLIENT_ID:"
echo $ARM_CLIENT_ID
echo "ARM_CLIENT_SECRET:"
echo $ARM_CLIENT_SECRET
echo "ARM_SUBSCRIPTION_ID:"
echo $ARM_SUBSCRIPTION_ID
echo "ARM_TENANT_ID:"
echo $ARM_TENANT_ID
echo "======================================================================================================="
exit
fi
echo "====================================Finished to SetUp Variable=========================================="
echo "=================================Start Execution Process Now !!!========================================"
./99_automate.sh >> $filename
echo "===============================Finished Execution Process Now !!!======================================="
terraform output > ./result
if grep -q 'no outputs defined' "./result"; then
exit
else
echo "================================Start Export AKS Kube Configure========================================="
terraform output kube_config > ./aks-config
tail -n +2 "aks-config" > "aks-config.tmp" && mv "aks-config.tmp" "aks-config"
sed '$d' aks-config > "aks-config.tmp" && mv "aks-config.tmp" "aks-config"
export KUBECONFIG=./aks-config 
echo "=============================Finsihed Export AKS Kube Configure========================================="
echo "=============================Start Deploy Test Application=============================================="
kubectl get nodes
kubectl apply -f ./demo/backend.yaml
kubectl apply -f ./demo/frontend.yaml
kubectl apply -f ./demo/client.yaml
kubectl apply -f ./demo/management.yaml
echo "=======================Wait for Ingress Application GW to Operate========================================"
sleep 260 # Waits 4 minutes.
echo " Please open this public ip address via browser for check demo application"
kubectl get ing -n=management-ui
echo "=============================Finished Deploy Test Application==========================================="
fi