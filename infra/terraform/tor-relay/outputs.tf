/*
output "tor-relay-01-mac" {
    description = "Relay mac address:"
    value = "${proxmox_vm_qemu.tor-relay-0[count.index].network[0].hwaddr}"
}
output "tor-relay-01-ip" {
    description = "Relay IP address:"
    value = "${proxmox_vm_qemu.tor-relay-0[count.index].network[0].ip}"
}
*/