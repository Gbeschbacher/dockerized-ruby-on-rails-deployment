resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.app_base.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_group.id]

  tags = {
    Name = "ExampleAppServer"
  }
}
