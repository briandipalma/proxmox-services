terraform {
  backend "local" {
    path = "../../my-data/terraform/terraform.tfstate"
  }

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}
