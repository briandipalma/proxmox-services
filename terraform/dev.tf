resource "proxmox_lxc" "dev" {
  target_node     = "pve"
  hostname        = "dev"
  ostemplate      = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start           = true
  onboot          = true
  vmid            = var.dev_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "10G"
  }

  mountpoint {
    mp      = "/dev/"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/dev"
    volume  = "/mnt/storage/dev"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.dev_ip
    ip6    = "auto"
    hwaddr = var.dev_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
    ]
  }
}
