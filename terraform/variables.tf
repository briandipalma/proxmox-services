variable "proxmox_api_url" {
  description = "The Proxmox API URL"
  type        = string
  default     = "https://pve.test:8006/api2/json"
}

variable "proxmox_user" {
  description = "The Proxmox user"
  type        = string
  default     = "root@pam"
}

variable "proxmox_password" {
  description = "The Proxmox user password"
  type        = string
}

variable "pub_ssh_key" {
  description = "Public SSH key for passwordless login/Ansible admining"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "gateway_ip" {
  description = "LXC gateway IP"
  type        = string
  default     = "192.168.1.1"
}

//
// Services variables
//

variable "traefik_lxcid" {
  type    = number
  default = 500
}

variable "jellyfin_lxcid" {
  type    = number
  default = 501
}

variable "sonarr_lxcid" {
  type    = number
  default = 502
}

variable "radarr_lxcid" {
  type    = number
  default = 503
}

variable "qbittorrent_lxcid" {
  type    = number
  default = 506
}

variable "nzbget_lxcid" {
  type    = number
  default = 507
}

variable "samba_lxcid" {
  type    = number
  default = 508
}

variable "pi-hole-primary_lxcid" {
  type    = number
  default = 509
}

variable "unifi_lxcid" {
  type    = number
  default = 510
}

variable "prowlarr_lxcid" {
  type    = number
  default = 511
}

variable "tdarr_lxcid" {
  type    = number
  default = 512
}

variable "bazarr_lxcid" {
  type    = number
  default = 513
}

variable "beets_lxcid" {
  type    = number
  default = 514
}

variable "network_lxcid" {
  type    = number
  default = 515
}

variable "work_docker_lxcid" {
  type    = number
  default = 516
}

variable "ipa_lxcid" {
  type    = number
  default = 517
}

variable "keycloak_lxcid" {
  type    = number
  default = 518
}

variable "dev_lxcid" {
  type    = number
  default = 519
}

variable "traefik_mac" {
  type    = string
  default = "B6:1A:E1:C6:86:03"
}

variable "jellyfin_mac" {
  type    = string
  default = "7A:25:2B:1B:BE:EF"
}

variable "sonarr_mac" {
  type    = string
  default = "F2:07:09:E7:05:32"
}

variable "radarr_mac" {
  type    = string
  default = "36:67:C0:9C:48:9C"
}

variable "qbittorrent_mac" {
  type    = string
  default = "EE:28:5A:1B:D5:DD"
}

variable "nzbget_mac" {
  type    = string
  default = "12:E8:11:73:7E:38"
}

variable "samba_mac" {
  type    = string
  default = "CE:04:BF:59:F1:7F"
}

variable "pi-hole-primary_mac" {
  type    = string
  default = "BA:B8:76:70:58:90"
}

variable "unifi_mac" {
  type    = string
  default = "02:58:BD:D4:C1:FC"
}

variable "prowlarr_mac" {
  type    = string
  default = "06:90:EE:CD:05:87"
}

variable "tdarr_mac" {
  type    = string
  default = "2A:F0:E4:07:39:3B"
}

variable "bazarr_mac" {
  type    = string
  default = "B2:BE:AF:7B:2F:9F"
}

variable "beets_mac" {
  type    = string
  default = "7A:61:4E:F6:ED:3A"
}

variable "network_mac" {
  type    = string
  default = "42:98:73:F5:A2:A8"
}

variable "work_docker_mac" {
  type    = string
  default = "F6:82:27:AF:F1:47"
}

variable "ipa_mac" {
  type    = string
  default = "76:96:E0:16:62:4F"
}

variable "keycloak_mac" {
  type    = string
  default = "2A:53:05:0D:28:29"
}

variable "dev_mac" {
  type    = string
  default = "9A:AD:16:AF:35:26"
}

variable "pi-hole-primary_ip" {
  type    = string
  default = "192.168.1.2/24"
}

variable "traefik_ip" {
  type    = string
  default = "192.168.1.4/24"
}

variable "unifi_ip" {
  type    = string
  default = "192.168.1.6/24"
}

variable "jellyfin_ip" {
  type    = string
  default = "192.168.1.21/24"
}

variable "sonarr_ip" {
  type    = string
  default = "192.168.1.22/24"
}

variable "radarr_ip" {
  type    = string
  default = "192.168.1.23/24"
}

variable "prowlarr_ip" {
  type    = string
  default = "192.168.1.24/24"
}

variable "nzbget_ip" {
  type    = string
  default = "192.168.1.25/24"
}

variable "qbittorrent_ip" {
  type    = string
  default = "192.168.1.26/24"
}

variable "bazarr_ip" {
  type    = string
  default = "192.168.1.27/24"
}

variable "samba_ip" {
  type    = string
  default = "192.168.1.28/24"
}

variable "network_ip" {
  type    = string
  default = "192.168.1.29/24"
}

variable "beets_ip" {
  type    = string
  default = "192.168.1.30/24"
}

variable "keycloak_ip" {
  type    = string
  default = "192.168.1.31/24"
}

variable "ipa_ip" {
  type    = string
  default = "192.168.1.32/24"
}

variable "tdarr_ip" {
  type    = string
  default = "192.168.1.33/24"
}

variable "work_docker_ip" {
  type    = string
  default = "192.168.1.34/24"
}

variable "dev_ip" {
  type    = string
  default = "192.168.1.35/24"
}
