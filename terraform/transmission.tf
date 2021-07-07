resource "proxmox_lxc" "transmission" {
  target_node  = "pve"
  hostname     = "transmission"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.transmission_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/opt/transmission/data"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/transmission/config"
    volume  = "/mnt/storage/appdata/transmission/config"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    hwaddr = var.transmission_mac
  }
  
  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}
