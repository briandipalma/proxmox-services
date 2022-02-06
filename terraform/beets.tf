resource "proxmox_lxc" "beets" {
  target_node     = "pve"
  hostname        = "beets"
  ostemplate      = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = <<-EOT
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6iDv3SIqB+4ycb9iuDNbxZ5Koz87LKTZG/QXuwBZgN brian@pop-os-2021-03-20
	  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4ziGzxYeuB2dNSxurjyxvQTGxZwvoiTs/0pxmnPcDz brian@oneplus3t-2022-02-06
  EOT
  start           = true
  onboot          = true
  vmid            = var.beets_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/root/.config/beets/"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/beets/config"
    volume  = "/mnt/storage/appdata/beets/config"
  }

  mountpoint {
    mp      = "/mnt/storage/media"
    size    = "8G"
    slot    = 1
    key     = "1"
    storage = "/mnt/storage/media"
    volume  = "/mnt/storage/media"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.beets_ip
    ip6    = "auto"
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage
    ]
  }
}
