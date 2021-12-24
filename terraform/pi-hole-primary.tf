resource "proxmox_lxc" "pi-hole-primary" {
  target_node     = "pve"
  hostname        = "pi-hole-primary"
  ostemplate      = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start           = true
  onboot          = true
  vmid            = var.pi-hole-primary_lxcid
  memory          = 1024

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.pi-hole-primary_ip
    ip6    = "auto"
    hwaddr = var.pi-hole-primary_mac
  }
}
