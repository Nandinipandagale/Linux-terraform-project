variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of your EC2 key pair"
}

variable "public_key_path" {
  description = "Path to your public SSH key"
}

variable "linux_ami" {
  description = "AMI ID for Linux instance"
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2 in ap-south-1
}

variable "windows_ami" {
  description = "AMI ID for Windows Server instance"
  default     = "ami-0e0ff68cb8e9a188a" # Windows Server 2019 in ap-south-1
}
