data "terraform_remote_state" "network_details" {
  backend = "s3"
  config = {
    bucket = "student.2-dan-gill-bucket"
    key = "student.2-network-state"
    region = var.region
  }
}

module "webserver" {
  source = "./modules/linux_node"
  instance_count = "0"
  ami = "ami-08d4ac5b634553e16"
  instance_type = "t3.micro"
  key_name = data.terraform_remote_state.network_details.outputs.key_name
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
    Name = var.webserver_prefix
  }
  chef_policy_name = "webserver"
}

module "loadbalancer" {
  source = "./modules/linux_node"
  instance_count = "0"
  ami = "ami-08d4ac5b634553e16"
  instance_type = "t3.micro"
  key_name = data.terraform_remote_state.network_details.outputs.key_name
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
    Name = var.loadbalancer_prefix
  }
  chef_policy_name = "haproxy_loadbalancer"
  depends_on = [module.webserver,module.web_docker_host]
}

module "web_docker_host" {
  source = "./modules/linux_node"
  instance_count = "0"
  ami = "ami-08d4ac5b634553e16"
  instance_type = "t3.micro"
  key_name = data.terraform_remote_state.network_details.outputs.key_name
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
    Name = var.web_docker_host_prefix
  }
  chef_policy_name = "web_docker_host"
}

module "lb_docker_host" {
  source = "./modules/linux_node"
  instance_count = "0"
  ami = "ami-08d4ac5b634553e16"
  instance_type = "t3.micro"
  key_name = data.terraform_remote_state.network_details.outputs.key_name
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
    Name = var.lb_docker_host_prefix
  }
  chef_policy_name = "lb_docker_host"
  depends_on = [module.web_docker_host]
}

module "k8s_control_plane" {
  source = "./modules/linux_node"
  instance_count = "1"
  ami = "ami-08d4ac5b634553e16"
  instance_type = "t2.medium"
  key_name = data.terraform_remote_state.network_details.outputs.key_name
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
    Name = var.k8s_control_plane_host_prefix
  }
  chef_policy_name = "k8s_control_plane"
}

module "k8s_worker_node" {
  source = "./modules/linux_node"
  instance_count = "1"
  ami = "ami-08d4ac5b634553e16"
  instance_type = "t2.small"
  key_name = data.terraform_remote_state.network_details.outputs.key_name
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
    Name = var.k8s_worker_node_host_prefix
  }
  chef_policy_name = "k8s_worker_node"
}
