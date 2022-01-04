resource "proxmox_lxc" "qbittorrent" {
  target_node     = "pve"
  hostname        = "qbittorrent"
  ostemplate      = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start           = true
  onboot          = true
  vmid            = var.qbittorrent_lxcid
  memory          = 5120

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
