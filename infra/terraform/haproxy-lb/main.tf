## Deploys 2 LXC containers used for HAproxy

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
    start           = false
    tags            = "ubuntu;terraform;ansible"

    ssh_public_keys = <<-EOT
        ${var.ssh_public_key}
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
    start           = false
    tags            = "ubuntu;terraform;ansible"

    ssh_public_keys = <<-EOT
        ${var.ssh_public_key}
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
