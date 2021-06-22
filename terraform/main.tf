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
