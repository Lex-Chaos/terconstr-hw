data "yandex_compute_image" "ubuntu" {
  family = var.os_family
}

resource "yandex_compute_instance" "web" {
  depends_on = [yandex_compute_instance.db]
  count = 2
  name        = "web-${count.index+1}"
  hostname    = "web-${count.index+1}"
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
#   allow_stopping_for_update = true
}