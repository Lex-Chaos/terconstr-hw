resource "yandex_compute_disk" "storage_disk" {
  count = 3
  name  = "storage_disk-${count.index+1}"
  size  = var.storage_disk_size
  type  = var.storage_disk_type 
}

resource "yandex_compute_instance" "storage" {
  name        = var.storage_vm_name
  hostname    = var.storage_vm_name
  platform_id = var.platform_id

  resources {
    cores         = var.common_resources.cores
    memory        = var.common_resources.memory
    core_fraction = var.common_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
#       type     = "network-hdd"
#       size     = 5
    }
  }

    dynamic "secondary_disk" {
    for_each = toset(yandex_compute_disk.storage_disk.*.id)
    content {
      disk_id = secondary_disk.key
    }
  }

  metadata = {
    serial-port-enable = var.serial
    ssh-keys = local.ssh_key
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
}