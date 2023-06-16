output "ec2_public_dns" {
  value = aws_instance.ec2.public_dns
}

output "eip" {
  value = aws_eip.eip.public_ip
}

