resource "proxmox_lxc" "jellyfin" {
  target_node  = "pve"
  hostname     = "jellyfin"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = "500"
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

resource "proxmox_lxc" "proxmox_services" {
  count = length(var.hostnames)
  target_node  = "pve"
  hostname     = var.hostnames[count.index]
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.vmids[count.index]

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
    hwaddr = var.macs[count.index]
  }
}
