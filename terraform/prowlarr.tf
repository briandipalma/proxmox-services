resource "proxmox_lxc" "prowlarr" {
  target_node  = "pve"
  hostname     = "prowlarr"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.prowlarr_lxcid
  memory = 1024

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/Prowlarr-data"
    size    = "1G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/prowlarr/config"
    volume  = "/mnt/storage/appdata/prowlarr/config"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.prowlarr_ip
    ip6    = "auto"
    hwaddr = var.prowlarr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}
