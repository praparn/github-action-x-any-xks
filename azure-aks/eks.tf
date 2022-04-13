resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "lab" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.region
    resource_group_name = var.resource_group
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "lab" {
    solution_name         = "ContainerInsights"
    location              = var.region
    resource_group_name   = var.resource_group
    workspace_resource_id = azurerm_log_analytics_workspace.lab.id
    workspace_name        = azurerm_log_analytics_workspace.lab.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name                = var.cluster_name
    location            = var.location
    resource_group_name = var.resource_group
    public_network_access_enabled    = var.cluster_public
    http_application_routing_enabled = var.cluster_httprouting
    dns_prefix          = "${var.cluster_name}-prefix"
    kubernetes_version  = var.cluster_version

    linux_profile {
        admin_username = "ubuntu"
        ssh_key {
            key_data = file(var.ssh_public_key)
        }
    }

    default_node_pool {
        name            = var.default_node_pool
        zones           = var.aks_zone
        max_pods        = var.worker_maxpods
        vm_size         = var.worker_size
        type            = var.worker_type
        os_disk_type    = var.worker_disk_type
        os_sku          = var.worker_os
        os_disk_size_gb      = var.worker_disksize
        orchestrator_version = var.cluster_version
        enable_host_encryption = var.worker_encrypt
        enable_auto_scaling  = var.cluster_autoscale
        node_count           = var.worker_count
        max_count            = var.cluster_autoscale_max
        min_count            = var.cluster_autoscale_min
        vnet_subnet_id       = azurerm_subnet.aks_subnet.id
        linux_os_config {        
            sysctl_config {
                fs_file_max = var.worker_sysctl_fsfilemax
                vm_vfs_cache_pressure = var.worker_sysctl_vmvfscachepressure
                vm_swappiness = var.worker_sysctl_vmswappiness
                kernel_threads_max = var.worker_sysctl_kernelthreadsmax
                net_core_rmem_default = var.worker_sysctl_netcorermemdefault
                net_core_rmem_max = var.worker_sysctl_netcorermemmax
                net_core_wmem_default = var.worker_sysctl_netcorewmemdefault
                net_core_wmem_max = var.worker_sysctl_netcorewmemmax
                net_ipv4_tcp_fin_timeout = var.worker_sysctl_netipv4tcpfintimeout
                net_ipv4_tcp_keepalive_probes = var.worker_sysctl_netipv4tcpkeepaliveprobes
                net_ipv4_tcp_keepalive_time = var.worker_sysctl_netipv4tcpkeepalivetime
                net_ipv4_tcp_tw_reuse = var.worker_sysctlnetipv4tcptwreuse
            }
        }
        kubelet_config {
        container_log_max_line = var.kubelet_logmaxline
        container_log_max_size_mb = var.kubelet_logmaxmb
        image_gc_high_threshold = var. kubelet_imagegchighthreshold
        image_gc_low_threshold = var.kubelet_imagegclowthreshold
        }
    }

    service_principal {
        client_id     = var.ARM_CLIENT_ID
        client_secret = var.ARM_CLIENT_SECRET
    }

    oms_agent {
      log_analytics_workspace_id = azurerm_log_analytics_workspace.lab.id
    }

    ingress_application_gateway {
      gateway_name = "${var.cluster_name}-appgw"
      subnet_cidr = var.network_space_aksapp
    }

    network_profile {
        load_balancer_sku = var.load_balancer_sku
        network_plugin = var.network_plugin
        network_policy = var.network_policy
    }

    tags = {
        Environment = var.environment
    }
}