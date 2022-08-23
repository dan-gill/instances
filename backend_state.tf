terraform {
  backend "s3" {
    bucket = "student.2-dan-gill-bucket"
    key = "student.2-instance-state"
    region = "us-east-1"
  }
}
