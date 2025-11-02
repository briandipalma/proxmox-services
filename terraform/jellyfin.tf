resource "proxmox_lxc" "jellyfin" {
  target_node     = "pve"
  hostname        = "jellyfin"
  ostemplate      = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = <<-EOT
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0hWDvdigGG+CV1P73mdjz6b7fXBGmfhg962pDEgT/9 brian@samsung_s20_fe-2022-08-19
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7AORfN9dPrfHvH5KT0DFUQBmqdkGVpb1RTgs1TN2kN brian@infinitybook_pro14-2024-11-21
  EOT
  start           = true
  onboot          = true
  vmid            = var.jellyfin_lxcid
  memory          = 8192
  cores           = 8

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "6G"
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
    mp      = "/mnt/storage/media"
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
