resource "yandex_compute_instance" "vm-ubu" {
  name        = "vm-ubu"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8lape4adm5melne14m"
      size     = 50
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    ipv4      = true
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network1" {}

resource "yandex_vpc_subnet" "subnet1" {
  v4_cidr_blocks = ["10.100.0.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network1.id
}


resource "yandex_vpc_security_group" "sg2" {
  name        = "sg2"
  description = "Allow ssh and http"
  network_id  = yandex_vpc_network.network1.id

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["88.165.198.16/32"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "jfrog"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port = 8081
    to_port = 8082
  }

  ingress {
    protocol       = "TCP"
    description    = "http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port = 80
  }
  
  egress {
    protocol       = "ANY"
    description    = "allow all egress"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port = -1
  }
}

output "vm-1" {
  value = [yandex_compute_instance.vm-ubu.network_interface.0.ip_address,
  "${yandex_compute_instance.vm-ubu.network_interface.0.nat_ip_address}"]
}