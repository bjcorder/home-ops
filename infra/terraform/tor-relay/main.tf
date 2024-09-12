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

/*
  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "nfs-cluster-stor2"
        }
      }
    }
  }
*/
  ssh_user        = "srvadmin"
  ssh_private_key = <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACC0gOjglI/DdZI3Af6Knivk3ertNnj6SX8wV1eDWr+erQAAAJhHB3yORwd8
jgAAAAtzc2gtZWQyNTUxOQAAACC0gOjglI/DdZI3Af6Knivk3ertNnj6SX8wV1eDWr+erQ
AAAEDUELOm+hXn5R5et4poYgpP78W/5o0JAUXPzSnfU+ScSbSA6OCUj8N1kjcB/oqeK+Td
6u02ePpJfzBXV4Nav56tAAAAFXNydmFkbWluQHNlbWFwaG9yZS0wMQ==
-----END OPENSSH PRIVATE KEY-----

EOF

  os_type   = "cloud-init"
  ipconfig0 = "ip=10.59.99.221/24,gw=10.59.99.254"
  ciupgrade = 1
  ciuser = "srvadmin"
  nameserver = "10.59.1.253,10.59.1.252"

  sshkeys = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILSA6OCUj8N1kjcB/oqeK+Td6u02ePpJfzBXV4Nav56t srvadmin@semaphore-01
EOF

  provisioner "remote-exec" {
    inline = [
      "ip a"
    ]
  }
}