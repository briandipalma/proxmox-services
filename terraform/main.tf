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
    storage = "/srv/jellyfin/config"
    // Without 'volume' defined, Proxmox will try to create a volume with
    // the value of 'storage' + : + 'size' (without the trailing G) - e.g.
    // "/srv/host/bind-mount-point:256".
    // This behaviour looks to be caused by a bug in the provider.
    volume  = "/srv/jellyfin/config"
  }

  mountpoint {
    mp      = "/var/lib/jellyfin"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/srv/jellyfin/data"
    volume  = "/srv/jellyfin/data"
  }
  
  mountpoint {
    mp      = "/var/cache/jellyfin"
    size    = "8G"
    slot    = 2
    key     = "2"
    storage = "/srv/jellyfin/cache"
    volume  = "/srv/jellyfin/cache"
  }
  
  mountpoint {
    mp      = "/mnt/tvseries"
    size    = "8G"
    slot    = 3
    key     = "3"
    storage = "/mnt/storage/tvseries"
    volume  = "/mnt/storage/tvseries"
  }
  
  mountpoint {
    mp      = "/mnt/movies"
    size    = "8G"
    slot    = 4
    key     = "4"
    storage = "/mnt/storage/movies"
    volume  = "/mnt/storage/movies"
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
    mp      = "/etc/jellyfin"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/srv/test"
    // Without 'volume' defined, Proxmox will try to create a volume with
    // the value of 'storage' + : + 'size' (without the trailing G) - e.g.
    // "/srv/host/bind-mount-point:256".
    // This behaviour looks to be caused by a bug in the provider.
    volume  = "/srv/test"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    hwaddr = var.macs[count.index]
  }
}
