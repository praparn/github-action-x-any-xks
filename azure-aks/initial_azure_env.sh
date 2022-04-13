#!/bin/bash
today=`date '+%Y_%m_%d__%H_%M_%S'`;
filename="./log/Azure_Initial_$today.log"
clear
echo "======================================================================================================="
echo "Do you want to initial azure for environment? (Yes/No)"
echo "======================================================================================================="
echo "Pre-requistion for install: Azure-Cli (Ref:https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)"
echo "======================================================================================================="
read answer
if [ "${answer}" != 'Yes' ]; then
exit
fi
echo "======================================================================================================="
echo "Please login azure via browser with url: https://microsoft.com/devicelogin. Enter code as below"
echo "======================================================================================================="
az login --use-device-code
echo "======================================================================================================="
clear
result=$(az account list --output table | grep -c "SubscriptionId")
if [ $result -eq 0 ]; then
echo "======================================================================================================="
echo "We don't found your subscription on Portal. Please check and create subscription before operate next "
echo "======================================================================================================="
exit
else
  echo "======================================================================================================="
  echo "Do you want to create new service principle? (Yes/No)"
  echo "======================================================================================================="
  echo "Ref:https://docs.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash#create-a-service-principal"
  echo "======================================================================================================="
  read answer
  if [ "${answer}" == 'Yes' ]; then
  echo "======================================================================================================="
  echo "Please input your subscription:"
  echo "======================================================================================================="
  read answer1
  echo "============================Start to setup azure service principle====================================="
  echo "====================Please export service principle variable==========================================="
  az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${answer1}"
  echo "====================Please export service principle variable==========================================="
  echo "======================================================================================================="
  echo "export ARM_CLIENT_ID=00000000-0000-0000-0000-000000000000"                                           
  echo "export ARM_CLIENT_SECRET=00000000-0000-0000-0000-000000000000"
  echo "export ARM_SUBSCRIPTION_ID=00000000-0000-0000-0000-000000000000"
  echo "export ARM_TENANT_ID=00000000-0000-0000-0000-000000000000"
  echo "======================================================================================================="
  echo "============================Finished to setup azure service principle====================================="
  fi
fi
echo "======================================================================================================="
echo "Do you want to create resource group and storage account for environment? (Yes/No)."
echo "Remark: You must to have at least create subscription on Azure portal for operate"
echo "======================================================================================================="
echo "Pre-requistion for install: Azure-Cli (Ref:https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)"
echo "======================================================================================================="
read answer
if [ "${answer}" != 'Yes' ]; then
exit
fi
echo "Please input region name: (Default:eastasia) (https://azuretracks.com/2021/04/current-azure-region-names-reference/)"
read answer2
if [ -z "$answer2" ]; then
exit
fi
echo "Please input resource group name:"
read answer3
if [ -z "$answer3" ]; then
exit
fi
echo "Please input cluster name (aks):"
read answer4
if [ -z "$answer4" ]; then
exit
fi
echo "Please input storage account name: (Remark: Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only)"
read answer5
if [ -z "$answer5" ]; then
exit
fi
echo "==============================Start to setup azure environment========================================="
# Create Resource Group
az group create --name $answer3 --location $answer2
# Create Storage Account
az storage account create --name $answer5 --resource-group $answer3 --location $answer2 --sku Standard_RAGRS --kind StorageV2
# Create Storage Account
az storage container create --name tfstate --account-name $answer5  --fail-on-exist
echo "======================Automatic export all of value on variable.tf====================================="
sed -i -e "s/###resource_group###/$answer3/g" ./terraform.tfvars
sed -i -e "s/###storage_accname###/$answer5/g" ./terraform.tfvars
sed -i -e "s/###cluster_name###/$answer4/g" ./terraform.tfvars
sed -i -e "s/###resource_group###/$answer3/g" ./00_provider.tf
sed -i -e "s/###storage_accname###/$answer5/g" ./00_provider.tf
sed -i -e "s/###cluster_name###/$answer4/g" ./00_provider.tf
echo "======================Automatic export all of value on variable.tf====================================="
az logout
echo "===========================Finished to setup azure environment========================================="