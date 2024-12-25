resource "local_file" "ans_inv" {
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.db,
    yandex_compute_instance.storage
  ]
  filename = "./hosts.ini"
  content = templatefile("hosts.tftpl",
    {
      web = yandex_compute_instance.web,
      db = yandex_compute_instance.db,
      storage = [yandex_compute_instance.storage]
    }
  )
}