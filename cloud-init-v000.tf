resource "proxmox_vm_qemu" "cloudinit-k8s-master" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "srvpve01"
    desc = "Cloudinit Ubuntu"
    count = 1
    onboot = true
    vmid = "801${count.index + 1}"

    # The template name to clone this vm from
    clone = "ubuntu-2204-cloudinit"

    # Activate QEMU agent for this VM
    agent = 0

    os_type = "cloud-init"
    cores = 2
    sockets = 2
    numa = true
    vcpus = 0
    cpu = "host"
    memory = 8096
    name = "k8s-master-0${count.index + 1}"

    cloudinit_cdrom_storage = "local-lvm"
    scsihw   = "virtio-scsi-single" 
    bootdisk = "scsi0"

    disks {
        scsi {
            scsi0 {
                disk {
                storage = "local-lvm"
                size = 32
                }
            }
        }
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=172.16.0.21${count.index + 1}/24,gw=172.16.0.1"
    ciuser = "ubuntu"
}

resource "proxmox_vm_qemu" "cloudinit-k8s-worker" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "srvpve01"
    desc = "Cloudinit Ubuntu"
    count = 2
    onboot = true
    vmid = "802${count.index + 1}"

    # The template name to clone this vm from
    clone = "ubuntu-2204-cloudinit"

    # Activate QEMU agent for this VM
    agent = 0

    os_type = "cloud-init"
    cores = 2
    sockets = 2
    numa = true
    vcpus = 0
    cpu = "host"
    memory = 8096
    name = "k8s-worker-0${count.index + 1}"

    cloudinit_cdrom_storage = "local-lvm"
    scsihw   = "virtio-scsi-single" 
    bootdisk = "scsi0"

    disks {
        scsi {
            scsi0 {
                disk {
                storage = "local-lvm"
                size = 32
                }
            }
        }
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=172.16.0.22${count.index + 1}/24,gw=172.16.0.1"
    ciuser = "ubuntu"
}