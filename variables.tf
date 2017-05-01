variable "platform" {
  default     = "ubuntu"
  description = "The OS Platform"
}
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "user" {
  default = {
    ubuntu  = "ubuntu"
    rhel6   = "ec2-user"
    centos6 = "centos"
    centos7 = "centos"
    rhel7   = "ec2-user"
  }
}
variable "instance_type" {
  default     = "t2.micro"
  description = "AWS Instance type, if you change, make sure it is compatible with AMI, not all AMIs allow all instance types "
}
variable "key_name" {
  description = "SSH key name in your AWS account for AWS instances."
}

variable "key_path" {
  description = "Path to the private key specified by key_name."
}

variable "tagName" {
  default     = "myec2"
  description = "Name tag for the servers"
}

