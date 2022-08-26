output "webserver_vm_public_ip" {
  value = module.webserver.*.public_ip
}

output "loadbalancer_vm_public_ip" {
  value = module.loadbalancer.*.public_ip
}

output "web_docker_host_public_ip" {
  value = module.web_docker_host.*.public_ip
}

output "lb_docker_host_public_ip" {
  value = module.lb_docker_host.*.public_ip
}

output "k8s_control_plane_public_ip" {
  value = "${module.k8s_control_plane.*.public_ip}"
}

output "k8s_worker_node_public_ip" {
  value = "${module.k8s_worker_node.*.public_ip}"
}
