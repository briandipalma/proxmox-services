resource "proxmox_lxc" "ipa" {
  target_node  = "pve"
  hostname     = "ipa"
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.ipa_lxcid
  memory = 1024

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/IPA-data"
    size    = "1G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/ipa/config"
    volume  = "/mnt/storage/appdata/ipa/config"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.ipa_ip
    ip6    = "auto"
    hwaddr = var.ipa_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}
