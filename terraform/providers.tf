provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  pm_user = var.proxmox_user
  pm_password = var.proxmox_password
  // Required when using self signed certs
  pm_tls_insecure = true
}
