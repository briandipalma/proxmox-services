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

variable "hostnames" {
  description = "Proxmox services hostnames"
  type = list(string)
  default = ["tv"]
}

variable "pub_ssh_key" {
  description = "Public SSH key for passwordless login/Ansible admining"
  type = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "vmids" {
  description = "LXC IDs"
  type = list(string)
  default = ["501"]
}

variable "macs" {
  description = "Proxmox services MACs"
  type = list(string)
  default = ["F2:07:09:E7:05:32"]
}
