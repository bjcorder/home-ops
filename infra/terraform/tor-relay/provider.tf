terraform {
    required_version = ">= 0.14"
    required_providers {
        proxmox = {
            source = "bpg/proxmox"
            version = "0.64.0"
        }
    }
}

provider "proxmox" {
    endpoint            = var.proxmox_api_url
    api_token           = var.proxmox_api_token
    insecure            = true

    ssh {
        agent       = false
        username    = var.ssh_user
        #private_key = file(var.ssh_private_key_file)
  }
}