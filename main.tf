data "terraform_remote_state" "network_details" {
  backend = "s3"
  config = {
    bucket = "student.2-dan-gill-bucket"
    key = "student.2-network-state"
    region = "us-east-1"
  }
}
