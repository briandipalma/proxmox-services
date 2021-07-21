resource "proxmox_lxc" "traefik" {
  target_node  = "pve"
  hostname     = "traefik"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.traefik_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = "192.168.1.1"
    ip     = "192.168.1.4/24"
    ip6    = "auto"
    hwaddr = var.traefik_mac
  }
}
