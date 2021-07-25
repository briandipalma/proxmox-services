resource "proxmox_lxc" "nzbget" {
  target_node  = "pve"
  hostname     = "nzbget"
  ostemplate   = "local:vztmpl/ubuntu-20.10-standard_20.10-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.nzbget_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/nzbget-config"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/nzbget/config"
    volume  = "/mnt/storage/appdata/nzbget/config"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = "192.168.1.1"
    ip     = "192.168.1.16/24"
    ip6    = "auto"
    hwaddr = var.nzbget_mac
  }
  
  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}
