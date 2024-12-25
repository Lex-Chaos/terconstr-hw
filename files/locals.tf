locals {
  ssh_key = "ubuntu:${file("./id_ed25519.pub")}"
} 