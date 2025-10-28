provider "aws" {
  region = var.aws_region
}

# 1. Create a new VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "my-custom-vpc"
  }
}

# 2. Create a public subnet
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "my-public-subnet"
  }
}

# 3. Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-internet-gateway"
  }
}

# 4. Create a Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-public-route-table"
  }
}

# 5. Associate Route Table with Subnet
resource "aws_route_table_association" "my_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# 6. Create Security Group (allow SSH and RDP)
resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Allow SSH for Linux and RDP for Windows"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "SSH for Linux"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "RDP for Windows"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-sg"
  }
}

# 7. Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# 8. Create Linux EC2 Instance
resource "aws_instance" "linux_instance" {
  ami           = var.linux_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.my_subnet.id
  key_name      = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "linux-instance"
  }
}

# 9. Create Windows EC2 Instance
resource "aws_instance" "windows_instance" {
  ami           = var.windows_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.my_subnet.id
  key_name      = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name = "windows-instance"
  }
}
