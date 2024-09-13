/*
data "local_sensitive_file" "ssh_public_key" {
  filename = var.ssh_public_key_file
}
*/

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "nfs-cluster-stor2"
  node_name    = "pve3"

  source_raw {
    data = <<-EOF
    #cloud-config
    users:
      - default
      - name: ${var.ssh_user}
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${var.ssh_public_key}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
        - apt update
        - apt install -y qemu-guest-agent net-tools
        - timedatectl set-timezone America/Chicago
        - hostnamectl set-hostname tor-relay-01
        - systemctl enable qemu-guest-agent
        - systemctl start qemu-guest-agent
        - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "nfs-iso2"
  node_name    = "pve3"

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img"
}

resource "proxmox_virtual_environment_vm" "tor-relay-01" {
  name      = "tor-relay-01"
  node_name = "pve3"
  description = "Managed by Terraform & Ansible"
  tags      = ["terraform", "ubuntu", "ansible"]
  on_boot   = true

  bios      = "ovmf"
  machine   = "q35"

  agent {
    enabled = true
  }

  operating_system {
    type      = "l26"
  }

  cpu {
    architecture  = "x86_64"
    cores = 2
    sockets = 1
    type = "x86-64-v2-AES"
    numa  = false
  }

  memory {
    dedicated = 2048
  }

  efi_disk {
    datastore_id  = "nfs-cluster-stor2"
    file_format   = "qcow2"
    type          = "4m"
    pre_enrolled_keys = true
  }

  disk {
    datastore_id  = "nfs-cluster-stor2"
    file_id       = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface     = "virtio0"
    file_format   = "qcow2"
    iothread      = true
    backup        = true
    ssd           = false
    discard       = "on"
    size          = 20
  }

  initialization {
    dns {
      servers   = ["1.1.1.1", "8.8.8.8"]
    }
    ip_config {
      ipv4 {
        address = "10.59.99.221/24"
        gateway = "10.59.99.254"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  network_device {
    bridge = "vmbr0"
    model       = "virtio"
    vlan_id = 99
  }

}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.tor-relay-01.ipv4_addresses[1][0]
}