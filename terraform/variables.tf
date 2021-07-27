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

variable "jackett_lxcid" {
  type = number
  default = 505
}

variable "qbittorrent_lxcid" {
  type = number
  default = 506
}

variable "nzbget_lxcid" {
  type = number
  default = 507
}

variable "samba_lxcid" {
  type = number
  default = 508
}

variable "pi-hole-primary_lxcid" {
  type = number
  default = 509
}

variable "unifi_lxcid" {
  type = number
  default = 510
}

variable "prowlarr_lxcid" {
  type = number
  default = 511
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

variable "jackett_mac" {
  type = string
  default = "EE:57:5F:63:A8:8A"
}

variable "qbittorrent_mac" {
  type = string
  default = "EE:28:5A:1B:D5:DD"
}

variable "nzbget_mac" {
  type = string
  default = "12:E8:11:73:7E:38"
}

variable "samba_mac" {
  type = string
  default = "CE:04:BF:59:F1:7F"
}

variable "pi-hole-primary_mac" {
  type = string
  default = "BA:B8:76:70:58:90"
}

variable "unifi_mac" {
  type = string
  default = "02:58:BD:D4:C1:FC"
}

variable "prowlarr_mac" {
  type = string
  default = "06:90:EE:CD:05:87"
}
