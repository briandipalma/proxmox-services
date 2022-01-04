resource "proxmox_lxc" "network" {
  target_node     = "pve"
  hostname        = "network"
  ostemplate      = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start           = true
  onboot          = true
  vmid            = var.network_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/duckdns"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/duckdns/config"
    volume  = "/mnt/storage/appdata/duckdns/config"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.network_ip
    ip6    = "auto"
    hwaddr = var.network_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}
