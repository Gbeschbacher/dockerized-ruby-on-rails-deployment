resource "aws_default_vpc" "vpc" {
  tags = {
    Name = "Default VPC"
  }
}
