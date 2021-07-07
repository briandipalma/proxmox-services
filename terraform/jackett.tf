resource "proxmox_lxc" "jackett" {
  target_node  = "pve"
  hostname     = "jackett"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.jackett_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/opt/jackett/data"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/jackett/config"
    volume  = "/mnt/storage/appdata/jackett/config"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip = "dhcp"
    hwaddr = var.jackett_mac
  }
  
  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}
