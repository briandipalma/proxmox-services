resource "proxmox_lxc" "keycloak" {
  target_node  = "pve"
  hostname     = "keycloak"
  ostemplate   = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)
  start = true
  onboot = true
  vmid = var.keycloak_lxcid

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  mountpoint {
    mp      = "/keycloak-config"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/mnt/storage/appdata/keycloak/config"
    volume  = "/mnt/storage/appdata/keycloak/config"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    gw     = var.gateway_ip
    ip     = var.keycloak_ip
    ip6    = "auto"
    hwaddr = var.keycloak_mac
  }

  lifecycle {
    ignore_changes = [
      mountpoint[0].storage
    ]
  }
}
