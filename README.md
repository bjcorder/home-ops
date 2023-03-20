<div align="center">

<img src="https://camo.githubusercontent.com/5b298bf6b0596795602bd771c5bddbb963e83e0f/68747470733a2f2f692e696d6775722e636f6d2f7031527a586a512e706e67" align="center" width="144px" height="144px"/>

### My Home Operations Repository

</div>

<div align="center">

[![Packer](https://img.shields.io/badge/v1.8.6-blue?style=for-the-badge&logo=packer&logoColor=white)](https://www.packer.io/)
[![Terraform](https://img.shields.io/badge/v1.3.9-blue?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Ansible](https://img.shields.io/badge/v2.3-blue?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com/)

[![Website](https://img.shields.io/uptimerobot/status/m792427620-04fcdd7089a84863ec9f398d?logo=github&logoColor=white&color=brightgreeen&label=Website&style=for-the-badge)](https://bjcorder.com)

</div>

---

## Overview

This is a mono repository for my home infrastructure and hosted services.

---

## Current State

My current environment is Docker provisioned overtop virtualized Ubuntu Server on Proxmox VE, with Portainer as a management front-end and a TrueNAS CIFS share for persistent container storage.

* _[Click here](./ansible/) to see my Ansible playbooks and roles._

### Current Hardware

| Device                    | Count | OS Disk Size | Data Disk Size              | Ram  | Operating System    | Purpose             |
|---------------------------|-------|--------------|-----------------------------|------|---------------------|---------------------|
| Palo Alto Networks PA-220 | 1     | -            | -                           | -    | PAN-OS 8.0          | Router/Firewall     |
| Netgear Unmanaged Switch  | 1     | -            | -                           | -    | -                   | Switching           |
| HP ProDesk 400 G3         | 2     | 256GB SSD    | -                           | 16GB | Proxmox VE 7.3      | Virtualization Host |
| HP EliteDesk 600 G3       | 1     | 256GB SSD    | -                           | 12GB | Proxmox VE 7.3      | Virtualization Host |
| Scrap NAS                 | 1     | 128GB SSD    | 6x1TB ZFS RAIDz2            | 8GB  | TrueNAS Scale 22.12 | NFS/CIFS Shares     |
| Raspberry Pi 4            | 1     | 32GB SD Card | -                           | 4GB  | RaspberryPi OS      | Emcomm Base Station |


### Current Internal Toolset

* [RedHat Ansible](https://www.ansible.com/)
* [HashiCorp Terraform](https://www.terraform.io/)
* [HashiCorp Packer](https://www.packer.io/)
* [Docker](https://www.docker.com)
* [Portainer](https://www.portainer.io/)
* [Pi-Hole](https://pi-hole.net/)
* [MySQL](https://www.mysql.com/)
* [Jellyfin](https://jellyfin.org/)

### Current External Tools

| Service                                         | Use                                                               | Cost           |
|-------------------------------------------------|-------------------------------------------------------------------|----------------|
| [BitWarden](https://bitwarden.com/)             | Open-source password vault                                        | FOSS           |
| [Cloudflare](https://www.cloudflare.com/)       | Domain, DNS and proxy management                                  | ~$30/yr        |
| [Proton Mail](https://proton.me)                | Secure email, calendar, VPN, and cloud storage                    | ~$11/mo        |
| [GitHub](https://github.com/)                   | Hosting this repository                                           | Free           |
| [Shields IO](https://shields.io/)               | Status and version labels for markdown                            | Free           |
| [CrowdSec](https://www.crowdsec.net/)           | Crowd-sourced, server-based IPS                                   | Free           |
| [Snyk](https://snyk.io/)                        | Container and dependency scanning                                 | Free           |
|                                                 |                                                                   | Total: ~$13/mo |

---

## DNS

### External DNS

Currently, my external DNS entries are handled through CloudFlare.

### Internal DNS

Internal DNS is handled by a Pi-Hole instance running on an Ubuntu Server 22.04.1 LTS virtual machine running on the Proxmox cluster.

### Ad Blocking

Ad blocking is provided by the internal Pi-Hole server through its integrated ad block functionality.

---

## Future State

---

## Changelog

See my [commit history](https://github.com/bjcorder/home-ops/commits/main)

---

## License

See [LICENSE](./LICENSE)