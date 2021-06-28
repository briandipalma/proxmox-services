resource "proxmox_lxc" "traefik" {
  target_node  = "pve"
  hostname     = "traefik"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = 500

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    hwaddr = "B6:1A:E1:C6:86:03"
  }
}

resource "proxmox_lxc" "jellyfin" {
  target_node  = "pve"
  hostname     = "jellyfin"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = 501
  memory = 4096

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
    ip = "dhcp"
    hwaddr = "7A:25:2B:1B:BE:EF"
  }
}

resource "proxmox_lxc" "sonarr" {
  target_node  = "pve"
  hostname     = "tv"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = 502

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
    ip = "dhcp"
    hwaddr = "F2:07:09:E7:05:32"
  }
}

resource "proxmox_lxc" "nzbhydra" {
  target_node  = "pve"
  hostname     = "nzbhydra"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = 503

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/mnt/nzbhydra"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/nzbhydra/config"
    volume  = "/mnt/storage/appdata/nzbhydra/config"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    hwaddr = "06:82:C0:36:D1:FB"
  }
}
