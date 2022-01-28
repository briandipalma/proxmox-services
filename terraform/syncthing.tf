resource "proxmox_lxc" "syncthing" {
  target_node     = "pve"
  hostname        = "syncthing"
  ostemplate      = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start           = true
  onboot          = true
  vmid            = var.syncthing_lxcid
  memory          = 1024

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/mnt/storage/appdata/syncthing/"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/syncthing/"
    volume  = "/mnt/storage/appdata/syncthing/"
  }

  mountpoint {
    mp      = "/mnt/storage/shares/brian"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/storage/shares/brian"
    volume  = "/mnt/storage/shares/brian"
  }

  mountpoint {
    mp      = "/mnt/storage/shares/charlene"
    size    = "8G"
    slot    = 2
    key     = "2"
    storage = "/mnt/storage/shares/charlene"
    volume  = "/mnt/storage/shares/charlene"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.syncthing_ip
    ip6    = "auto"
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage
    ]
  }
}
