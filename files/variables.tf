###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###ВМ
variable "os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство ОС"
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Тип платформы"
}

variable "preemptible" {
  type        = bool
  default     = true
  description = "preemptibles"
}

variable "serial" {
  type        = bool
  default     = true
  description = "Включение консоли"  
}

variable "common_resources" {
  description = "Общие ресурсы для ВМ"
  type        = map(number)
  default     = {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }
}

variable "storage_vm_name" {
  type        = string
  default     = "storage-vm"
  description = "Имя ВМ для storage"
}

variable "each_vm" {
  type = list(
    object(
      {
        vm_name=string,
        cpu=number,
        ram=number,
        disk=number
      }
    )
  )
  default = [
    {
      vm_name="main",
      cpu=2,
      ram=1,
      disk=10
    },
    {
      vm_name="replica",
      cpu=4,
      ram=2,
      disk=20
    }
  ]
} 

#Сеть
variable "nat" {
  type        = bool
  default     = true
  description = "Состояние nat"
}

#Диск
variable "storage_disk_size" {
  type        = number
  default     = 1
  description = "Размер storage-диска"
}

variable "storage_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Тип storage-диска"
}