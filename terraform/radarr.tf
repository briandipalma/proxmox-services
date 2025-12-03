resource "proxmox_lxc" "radarr" {
  target_node     = "pve"
  hostname        = "radarr"
  ostemplate      = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = <<-EOT
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7AORfN9dPrfHvH5KT0DFUQBmqdkGVpb1RTgs1TN2kN brian@infinitybook_pro14-2024-11-21
	 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0hWDvdigGG+CV1P73mdjz6b7fXBGmfhg962pDEgT/9 brian@samsung_s20_fe-2022-08-19
  EOT
  start           = true
  onboot          = true
  vmid            = var.radarr_lxcid
  memory          = 1024

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/Radarr-data"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/radarr/config"
    volume  = "/mnt/storage/appdata/radarr/config"
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
    ip     = var.radarr_ip
    ip6    = "auto"
    hwaddr = var.radarr_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage,
      mountpoint[1].storage
    ]
  }
}
