resource "proxmox_lxc" "rclone" {
  target_node     = "pve"
  hostname        = "rclone"
  ostemplate      = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = <<-EOT
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6iDv3SIqB+4ycb9iuDNbxZ5Koz87LKTZG/QXuwBZgN brian@pop-os-2021-03-20
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0hWDvdigGG+CV1P73mdjz6b7fXBGmfhg962pDEgT/9 brian@samsung_s20_fe-2022-08-19
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7AORfN9dPrfHvH5KT0DFUQBmqdkGVpb1RTgs1TN2kN brian@infinitybook_pro14-2024-11-21
  EOT
  start           = true
  onboot          = true
  vmid            = var.rclone_lxcid
  memory          = 1024

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/mnt/storage/appdata/rclone/"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/rclone/"
    volume  = "/mnt/storage/appdata/rclone/"
  }

  mountpoint {
    mp      = "/mnt/storage/media/videos"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/storage/media/videos"
    volume  = "/mnt/storage/media/videos"
  }

  mountpoint {
    mp      = "/mnt/storage/media/pictures"
    size    = "8G"
    slot    = 2
    key     = "2"
    storage = "/mnt/storage/media/pictures"
    volume  = "/mnt/storage/media/pictures"
  }

  mountpoint {
    mp      = "/mnt/storage/media/music"
    size    = "8G"
    slot    = 3
    key     = "3"
    storage = "/mnt/storage/media/music"
    volume  = "/mnt/storage/media/music"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.rclone_ip
    ip6    = "auto"
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
