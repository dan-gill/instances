resource "aws_instance" "my_vm" {
  count = var.instance_count
  ami = var.ami
  subnet_id = var.subnet_id
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  tags = var.tags
  provisioner "local-exec" {
    command = "sleep 30; knife bootstrap ${self.public_ip} -U ubuntu -i /home/ubuntu/terraform_base/keys/student.2-vm-key --sudo -N ${self.public_ip} --policy-name webserver --policy-group staging -c /home/ubuntu/chef-repo/.chef/config.rb --ssh-verify-host-key=never"
  }
  provisioner "remote-exec" {
    connection {
      host = self.public_ip
      type = "ssh"
      user = "ubuntu"
      agent = false
      private_key = file("../keys/student.2-vm-key")
    }
    inline = [
      "sudo chef-client -l info"
    ]
  }
  provisioner "local-exec" {
    when = destroy
    command = "knife node delete -y ${self.public_ip} -c /home/ubuntu/chef-repo/.chef/config.rb"
    on_failure = continue
  }
  provisioner "local-exec" {
    when = destroy
    command = "knife client delete -y ${self.public_ip} -c /home/ubuntu/chef-repo/.chef/config.rb"
    on_failure = continue
  }
}
