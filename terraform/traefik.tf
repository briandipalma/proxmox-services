resource "proxmox_lxc" "traefik" {
  target_node  = "pve"
  hostname     = "traefik"
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
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

  mountpoint {
    mp      = "/traefik-config"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/traefik/config"
    volume  = "/mnt/storage/appdata/traefik/config"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.traefik_ip
    ip6    = "auto"
    hwaddr = var.traefik_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}
