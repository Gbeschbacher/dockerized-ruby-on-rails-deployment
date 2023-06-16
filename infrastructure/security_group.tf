resource "aws_security_group" "security_group" {
  vpc_id = aws_default_vpc.vpc.id

  ingress {
    description = "Custom ssh port from the internet"
    from_port   = 936
    to_port     = 936
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "80 from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
