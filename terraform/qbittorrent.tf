resource "proxmox_lxc" "qbittorrent" {
  target_node     = "pve"
  hostname        = "qbittorrent"
  ostemplate      = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = <<-EOT
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6iDv3SIqB+4ycb9iuDNbxZ5Koz87LKTZG/QXuwBZgN brian@pop-os-2021-03-20
	 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0hWDvdigGG+CV1P73mdjz6b7fXBGmfhg962pDEgT/9 brian@samsung_s20_fe-2022-08-19
  EOT
  start           = true
  onboot          = true
  vmid            = var.qbittorrent_lxcid
  memory          = 8196

  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/qbittorrent-config"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/qbittorrent/config"
    volume  = "/mnt/storage/appdata/qbittorrent/config"
  }

  mountpoint {
    mp      = "/mnt/storage/downloads/torrents"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/storage/downloads/torrents"
    volume  = "/mnt/storage/downloads/torrents"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.qbittorrent_ip
    ip6    = "auto"
    hwaddr = var.qbittorrent_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage
    ]
  }
}
