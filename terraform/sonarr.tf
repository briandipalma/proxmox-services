resource "proxmox_lxc" "sonarr" {
  target_node     = "pve"
  hostname        = "sonarr"
  ostemplate      = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start           = true
  onboot          = true
  vmid            = var.sonarr_lxcid
  memory          = 1024

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/var/lib/sonarr"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/sonarr/config"
    volume  = "/mnt/storage/appdata/sonarr/config"
  }

  mountpoint {
    mp      = "/mnt/storage"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/storage"
    volume  = "/mnt/storage"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.sonarr_ip
    ip6    = "auto"
    hwaddr = var.sonarr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage
    ]
  }
}
