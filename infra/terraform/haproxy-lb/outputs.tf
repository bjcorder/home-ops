
output "haproxy-lb-01" {
    description = "HAproxy-01 mac address:"
    value = "${proxmox_lxc.haproxy-lb-01.network[0].hwaddr}"
}

output "haproxy-lb-02" {
    description = "HAproxy-01 mac address:"
    value = "${proxmox_lxc.haproxy-lb-02.network[0].hwaddr}"
}