#------------------------------------Critical Vault properties
resource_group = "AKS-Farm1"

storage_accname = "aksfarm1stgacc"

cluster_name = "aksfarm1"

#------------------------------------Basic System properties------------------------------------
region = "eastasia"

location = "East Asia"

log_analytics_workspace_name = "aksfarm1-wrkspc"

#--------------------------------------Basic AKS properties-------------------------------------
environment = "Development" #Environment Development, UAT, Production

cluster_version = "1.21.9"

cluster_public = true

worker_size = "Standard_B2s"

worker_disksize = 30

worker_count = 1

worker_maxpods = 30

network_space = "10.255.0.0/16"

network_space_aks = "10.255.0.0/20"

network_space_aksapp = "10.255.16.0/20"

#------------------------------------Advance AKS properties------------------------------------

cluster_admanage = true

cluster_rbac = true

cluster_httprouting = false

cluster_autoscale = true

cluster_autoscale_max = 3

cluster_autoscale_min = 1

worker_os = "Ubuntu"

worker_type = "VirtualMachineScaleSets"

worker_encrypt = false

worker_disk_type = "Managed"

network_policy = "calico"

network_plugin = "kubenet"

kubelet_logmaxline = 500

kubelet_logmaxmb = 10

kubelet_imagegchighthreshold = 60

kubelet_imagegclowthreshold = 10

worker_sysctl_vmvfscachepressure = 50

worker_sysctl_vmswappiness = 0

worker_sysctl_fsfilemax = 12000500

worker_sysctl_kernelthreadsmax = 513785

worker_sysctl_netcorermemdefault = 134217728

worker_sysctl_netcorermemmax = 134217728

worker_sysctl_netcorewmemdefault = 134217728

worker_sysctl_netcorewmemmax = 134217728

worker_sysctl_netipv4tcpfintimeout = 15

worker_sysctl_netipv4tcpkeepalivetime = 7200

worker_sysctlnetipv4tcptwreuse = true

load_balancer_sku = "standard"

load_balancer_profile = "standard"



#------------------------------------System define <Advance configure>------------------------------------

ssh_public_key = "./poc-eks.pub"

log_analytics_workspace_sku = "PerGB2018"
