/* Uses Cloud-Init options from Proxmox 5.2 */
resource "proxmox_vm_qemu" "cloudinit-test" {
  name        = "cloudinit-test"
  desc        = "tf description"
  target_node = "pve3"

  clone = "ubuntu-cloud-template"

  # The destination resource pool for the new VM
  #pool = "pool0"

  #storage = "nfs-cluster-stor2"
  cores   = 3
  sockets = 1
  memory  = 2560
  #disk_gb = 4

  network {
    model = "virtio"
    #name   = "eth0"
    bridge = "vmbr0"
    #ip     = "dhcp"
    tag = 99
  }


  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "nfs-cluster-stor2"
        }
      }
    }
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=10.59.99.221/24,gw=10.59.99.254"
  ciupgrade = true
  ciuser = "srvadmin"
  nameserver = "10.59.1.253,10.59.1.252"

  sshkeys = <<EOF
${ssh_public_key}
EOF

  provisioner "remote-exec" {
    inline = [
      "ip a"
    ]
  }
}