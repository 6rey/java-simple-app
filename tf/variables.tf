variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-central-1"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "ubuntu"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.micro"
}

variable "security_group" {
  description = "Name of security group"
  default     = "my-jenkins-security-group"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "ubuntu-ec2-instance"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-03fbd36aaa3d9d134"
}
