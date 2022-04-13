export TF_VAR_ARM_CLIENT_ID=$ARM_CLIENT_ID
export TF_VAR_ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET
export TF_VAR_ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID
export TF_VAR_ARM_TENANT_ID=$ARM_TENANT_ID
kubectl delete -f ./demo/frontend.yaml
kubectl delete -f ./demo/backend.yaml
kubectl delete -f ./demo/client.yaml
kubectl delete -f ./demo/management.yaml
terraform destroy --auto-approve
rm ./aks-config
export KUBECONFIG=""