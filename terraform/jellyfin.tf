resource "proxmox_lxc" "jellyfin" {
  target_node  = "pve"
  hostname     = "jellyfin"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.jellyfin_lxcid
  memory = 8192

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/etc/jellyfin"
    size    = "1G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/jellyfin/config"
    volume  = "/mnt/storage/appdata/jellyfin/config"
  }

  mountpoint {
    mp      = "/var/lib/jellyfin"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/storage/appdata/jellyfin/data"
    volume  = "/mnt/storage/appdata/jellyfin/data"
  }
  
  mountpoint {
    mp      = "/var/cache/jellyfin"
    size    = "8G"
    slot    = 2
    key     = "2"
    storage = "/mnt/storage/appdata/jellyfin/cache"
    volume  = "/mnt/storage/appdata/jellyfin/cache"
  }
  
  mountpoint {
    mp      = "/mnt/media"
    size    = "8G"
    slot    = 3
    key     = "3"
    storage = "/mnt/storage/media"
    volume  = "/mnt/storage/media"
  }
  
  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.jellyfin_ip
    ip6    = "auto"
    hwaddr = var.jellyfin_mac
  }
  
  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage,
      mountpoint[2].storage,
      mountpoint[3].storage
    ]
  }
}
