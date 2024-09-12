terraform {
    required_version = ">= 0.14"
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
    pm_tls_insecure = true
}