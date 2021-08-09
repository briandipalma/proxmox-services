resource "proxmox_lxc" "unifi" {
  target_node  = "pve"
  hostname     = "unifi"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.unifi_lxcid
  memory = 2048

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.unifi_ip
    ip6    = "auto"
    hwaddr = var.unifi_mac
  }
}
