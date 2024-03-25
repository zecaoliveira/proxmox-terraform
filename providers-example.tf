terraform {
    #required_version = ">= 1.1.0"
required_providers {
    proxmox = {
        source  = "telmate/proxmox"
        version = "3.0.1-rc1"
    }
}
}

provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://srvpve01.example.com:8006/api2/json"
    pm_api_token_secret = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
    pm_api_token_id = "srvterraform@pam!srvterraform"
    pm_log_enable = true
    pm_log_file   = "terraform-plugin-proxmox.log"
    pm_debug      = true
    pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
    }
}