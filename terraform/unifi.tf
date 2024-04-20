resource "proxmox_lxc" "unifi" {
  target_node     = "pve"
  hostname        = "unifi"
  ostemplate      = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  unprivileged    = true
  ostype          = "ubuntu"
  ssh_public_keys = <<-EOT
   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6iDv3SIqB+4ycb9iuDNbxZ5Koz87LKTZG/QXuwBZgN brian@pop-os-2021-03-20
	 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0hWDvdigGG+CV1P73mdjz6b7fXBGmfhg962pDEgT/9 brian@samsung_s20_fe-2022-08-19
  EOT
  start           = true
  onboot          = true
  vmid            = var.unifi_lxcid
  memory          = 2048

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.unifi_ip
    ip6    = "auto"
    hwaddr = var.unifi_mac
  }
}
