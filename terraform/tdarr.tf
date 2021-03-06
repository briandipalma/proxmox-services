resource "proxmox_lxc" "tdarr" {
  target_node     = "pve"
  hostname        = "tdarr"
  ostemplate      = "local:vztmpl/ubuntu-18.04-standard_18.04.1-1_amd64.tar.gz"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start           = true
  onboot          = true
  vmid            = var.tdarr_lxcid
  memory          = 1024

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/opt/Tdarr/configs"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/tdarr/config"
    volume  = "/mnt/storage/appdata/tdarr/config"
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
    gw     = var.gateway_ip
    ip     = var.tdarr_ip
    ip6    = "auto"
    hwaddr = var.tdarr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage
    ]
  }
}
