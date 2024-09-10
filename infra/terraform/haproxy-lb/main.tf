## Deploys 2 LXC containers used for HAproxy

terraform {
    required_providers {
        proxmox = {
            source = "Telmate/proxmox"
            version = "3.0.1-rc4"
        }
    }
}

provider "proxmox" {
    pm_api_url          = var.PROXMOX_API_URL
    pm_api_token_id     = var.PROXMOX_API_TOKEN_ID
    pm_api_token_secret = var.PROXMOX_API_TOKEN_SECRET
}

resource "proxmox_lxc" "haproxy-lb-01" {
    target_node     = "pve1"
    vmid            = 201
    hostname        = "haproxy-lb-01"
    ostemplate      = "nfs-iso2:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    password        = var.LXC_PASSWORD
    unprivileged    = true
    cores           = 1
    memory          = 512
    swap            = 1024
    start           = true
    tags            = "ubuntu;terraform;ansible"

    ssh_public_keys = <<-EOT
        ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILSA6OCUj8N1kjcB/oqeK+Td6u02ePpJfzBXV4Nav56t srvadmin@semaphore-01
    EOT

    rootfs {
        storage = "local-lvm"
        size    = "8G"
    }

    network {
        name    = "eth0"
        bridge  = "vmbr0"
        ip      = "dhcp"
        tag    = 20
    }
    
    features {
        nesting = false
    }
}

resource "proxmox_lxc" "haproxy-lb-02" {
    target_node     = "pve3"
    vmid            = 202
    hostname        = "haproxy-lb-02"
    ostemplate      = "nfs-iso2:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    password        = var.LXC_PASSWORD
    unprivileged    = true
    cores           = 1
    memory          = 512
    swap            = 1024
    start           = true
    tags            = "ubuntu;terraform;ansible"

    ssh_public_keys = <<-EOT
        ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILSA6OCUj8N1kjcB/oqeK+Td6u02ePpJfzBXV4Nav56t srvadmin@semaphore-01
    EOT

    rootfs {
        storage = "local-lvm"
        size    = "8G"
    }

    network {
        name    = "eth0"
        bridge  = "vmbr0"
        ip      = "dhcp"
        tag     = 20
    }

    features {
        nesting = false
    }
}
