##############################
#      Variable define       #
##############################

#  Credential Azure 
variable "ARM_CLIENT_ID" {}
variable "ARM_CLIENT_SECRET" {}
variable "ARM_SUBSCRIPTION_ID" {}
variable "ARM_TENANT_ID" {}
#  Credential Azure 
#  Critical Configure Variable
variable "resource_group" {
  description = "Resource group name on portal (pre-requistion before start terraform)"
}
variable "storage_accname" {
  description = "Resource group name on portal (pre-requistion before start terraform)"
}
variable cluster_name {
  description = "AKS cluster name"
}
#  Critical Configure Variable


###############################
#      General Properties     #
###############################
variable region {
   default    = "eastasia"
   description = "Region for housing EKS (https://azuretracks.com/2021/04/current-azure-region-names-reference/)"
}

variable location {
   default = "East Asia"
  description = "Full name of region for housing EKS (https://azuretracks.com/2021/04/current-azure-region-names-reference/)"
}

variable environment {
   default = "Development"
   description = "Environment to deploy (Development, UAT, Production)"
}

variable ssh_public_key {
   default = "~/.ssh/id_rsa.pub"
   description = "SSH public key location"
}

variable network_space {
   default = "10.255.0.0/16"
   description = "Total network cidr for cluster" 
}

variable network_space_aks {
   default = "10.255.0.0/20"
   description = "Total network cidr for AKS cluster itself (default: 10.255.0.0 - 10.255.15.254 at 4094 hosts)"
}

variable network_space_aksapp {
   default = "10.255.16.0/20"
   description = "Total network cidr for AKS cluster itself (default: 10.255.16.0 - 10.255.31.254 at 4094 hosts)"
}
###############################
#      AKS Properties         #
###############################

variable cluster_admanage {
  default = true
  description = "AKS cluster enable Active Directory Manage (true/false)"
}

variable cluster_public {
  default = true
  description = "AKS cluster enable access from public or not (true/false)"
}

variable cluster_rbac {
  default = true
  description = "AKS cluster enable RBAC on Active Directory (true/false)"
}
variable default_node_pool {
  default = "aksnodepool"
  description = "AKS node pool name (Avoid '-')"
}

variable cluster_version {
  default = "1.21.9"
  description = "AKS K8S version (1.21.9/1.22.4/1.22.6)"
}

variable cluster_autoscale {
  default = false
  description = "AKS autoscale"
}

variable cluster_autoscale_max {
  default = null
  description = "AKS maximum autoscale (If not autoscale. This need to be null. (1 - 1000)"
}

variable cluster_autoscale_min {
  default = null
  description = "AKS minimum autoscale (If not autoscale. This need to be null). (1 - 1000)"
}

variable aks_zone {
  default = ["1", "2", "3"]
  description = "AKS avaliable on which zone of Azure Cloud"
}

variable cluster_httprouting {
  default = false
  description = "AKS enable http routing (true/false). (Recommend enable on DEV environment)"
}

variable "worker_count" {
  default = 3
  description = "AKS total worker node 1 - 1000"
}

variable "worker_os" {
  default = "Ubuntu"
  description = "AKS worker os (Ubuntu/CBLMariner)"
  
}
variable "worker_maxpods" {
  default = 30
  description = "AKS maximum pods per node #Maximum pods per node is configurable up to 250"
}

variable "worker_encrypt" {
  default = false
  description = "AKS worker node encryption (true/false)"
}

variable "worker_type" {
  default = "VirtualMachineScaleSets"
  description = "AKS type of worker (AvailabilitySet/VirtualMachineScaleSets)"
}

variable "worker_disk_type" {
  default = "Managed"
  description = "AKS worker disk type (Ephemeral/Managed)"
}

variable "worker_size" {
  default = "Standard_D2_v2"
  description = "AKS vmware size for worker node"
}

variable "worker_disksize" {
  default = "30"
  description = "AKS worker disk size (GB)"
}

variable "worker_sysctl_vmswappiness" {
  default = 0
  description = "AKS WORKER TUNNING for vm_swappiness (0 - 100)"
}

variable "worker_sysctl_vmvfscachepressure" {
  default = 50
  description = "AKS WORKER TUNNING for vm_vfs_cache_pressure (0 - 100)"
}
variable "worker_sysctl_fsfilemax" {
  default = 12000500
  description = "AKS worker tunning for fs_file_max (8192 - 12000500)"
}

variable "worker_sysctl_kernelthreadsmax" {
  default = 513785
  description = "AKS worker tunning for kernel_threads_max (20 - 513785)"
}

variable "worker_sysctl_netcorermemdefault" {
  default = 134217728
  description = "AKS worker tunning for net_core_rmem_default (212992 - 134217728)"
}

variable "worker_sysctl_netcorermemmax" {
  default = 134217728
  description = "AKS worker tunning for net_core_rmem_max (212992 - 134217728)"
}

variable "worker_sysctl_netcorewmemdefault" {
  default = 134217728
  description = "AKS worker tunning for net_core_wmem_default (212992 - 134217728)"
}

variable "worker_sysctl_netcorewmemmax" {
  default = 134217728
  description = "AKS worker tunning for net_core_wmem_max (212992 - 134217728)"
}

variable "worker_sysctl_netipv4tcpfintimeout" {
  default = 15
  description = "AKS worker tunning for net_ipv4_tcp_fin_timeout (5 - 120)"
}

variable "worker_sysctl_netipv4tcpkeepaliveprobes" {
  default = 9
  description = "AKS worker tunning for net_ipv4_tcp_keepalive_probes (1 - 15)"
}

variable "worker_sysctl_netipv4tcpkeepalivetime" {
  default = 7200
  description = "AKS worker tunning for net_ipv4_tcp_keepalive_time (30 - 432000)"
}

variable "worker_sysctlnetipv4tcptwreuse" {
  default = true
  description = "AKS worker tunning for net_ipv4_tcp_tw_reuse (boolean)"
}

#https://docs.microsoft.com/en-us/azure/aks/custom-node-configuration

variable "kubelet_logmaxline" {
  default = 200
  description = "AKS kubelet tunning for max container logs (> 2 line)"
}

variable "kubelet_logmaxmb" {
  default = 200
  description = "AKS kubelet tunning for max container logs before rotated (MB)"
}

variable "kubelet_imagegchighthreshold" {
  default = 60
  description = "AKS kubelet high threshold for start GC image (0% - 100%)"
}

variable "kubelet_imagegclowthreshold" {
  default = 10
  description = "AKS kubelet low threshold for start GC image (0% - 100%)"
}

variable "network_policy" {
  default = "calico"
  description = "AKS network policy for use in cluster. (calico/azure)"
}

variable "network_plugin" {
  default = "kubenet"
  description = "AKS network plugin for cluster. (kubenet/azure)"
}

#https://docs.microsoft.com/en-us/azure/aks/custom-node-configuration

variable "load_balancer_sku" {
  default = "standard"
  description = "AKS SKU for load balancer. (basic/standard)"
}

variable "load_balancer_profile" {
  default = "standard"
  description = "AKS SKU for load balancer profile. (basic/standard)"
}

variable log_analytics_workspace_name {
  default = "template-log-aks-lab-2022"
  description = "Log workspace name. This will be add suffix with random number automatically"
}

variable log_analytics_workspace_sku {
  default = "PerGB2018"
  description = "SKU for pricing of log analytics on Azure (https://azure.microsoft.com/en-us/pricing/details/monitor/)"
}

#  AKA Properties #