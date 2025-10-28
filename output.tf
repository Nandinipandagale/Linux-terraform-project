output "linux_instance_public_ip" {
  description = "Public IP of Linux EC2 instance"
  value       = aws_instance.linux_instance.public_ip
}

output "windows_instance_public_ip" {
  description = "Public IP of Windows EC2 instance"
  value       = aws_instance.windows_instance.public_ip
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.my_subnet.id
}
