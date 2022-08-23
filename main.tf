data "terraform_remote_state" "network_details" {
  backend = "s3"
  config = {
    bucket = "student.2-dan-gill-bucket"
    key = "student.2-network-state"
    region = "us-east-1"
  }
}

resource "aws_instance" "my_vm" {
  ami = "ami-08d4ac5b634553e16"
  subnet_id = data.terraform_remote_state.network_details.outputs.my_subnet
  instance_type = "t3.micro"
  key_name = data.terraform_remote_state.network_details.outputs.key_name
  vpc_security_group_ids = data.terraform_remote_state.network_details.outputs.security_group_id_array
  tags = {
    Name = "student.2-vm1"
  }
}


