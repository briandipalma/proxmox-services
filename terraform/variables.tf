variable "proxmox_api_url" {
  description = "The Proxmox API URL"
  type = string
  default = "https://pve.test:8006/api2/json"
}

variable "proxmox_user" {
  description = "The Proxmox user"
  type = string
  default = "root@pam"
}

variable "proxmox_password" {
  description = "The Proxmox user password"
  type = string
}

variable "pub_ssh_key" {
  description = "Public SSH key for passwordless login/Ansible admining"
  type = string
  default = "~/.ssh/id_ed25519.pub"
}

//
// Services variables
//

variable "traefik_lxcid" {
  type = number
  default = 500
}

variable "jellyfin_lxcid" {
  type = number
  default = 501
}

variable "sonarr_lxcid" {
  type = number
  default = 502
}

variable "radarr_lxcid" {
  type = number
  default = 503
}

variable "nzbhydra_lxcid" {
  type = number
  default = 504
}

variable "traefik_mac" {
  type = string
  default = "B6:1A:E1:C6:86:03"
}

variable "jellyfin_mac" {
  type = string
  default = "7A:25:2B:1B:BE:EF"
}

variable "sonarr_mac" {
  type = string
  default = "F2:07:09:E7:05:32"
}

variable "radarr_mac" {
  type = string
  default = "36:67:C0:9C:48:9C"
}

variable "nzbhydra_mac" {
  type = string
  default = "06:82:C0:36:D1:FB"
}
