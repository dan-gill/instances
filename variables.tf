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

variable "lb_docker_host_prefix" {
  default = "student.2-lb_docker_host-vm"
}

variable "k8s_control_plane_host_prefix" {
  default = "student.2-k8s_control_plane"
}

variable "k8s_worker_node_host_prefix" {
  default = "student.2-k8s_worker_node"
}
