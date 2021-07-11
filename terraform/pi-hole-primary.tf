resource "proxmox_lxc" "pi-hole-primary" {
  target_node  = "pve"
  hostname     = "pi-hole-primary"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.pi-hole-primary_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    hwaddr = var.pi-hole-primary_mac
  }
}
