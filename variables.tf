variable "region" {
  default = "us-east-1"
}

variable "profile" {
  default = "student.2"
}

variable "webserver_prefix" {
  default = "student.2-webserver-vm"
}

variable "loadbalancer_prefix" {
  default = "student.2-loadbalancer-vm"
}

variable "web_docker_host_prefix" {
  default = "student.2-web_docker_host"
}
