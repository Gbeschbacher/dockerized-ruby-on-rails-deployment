variable "aws_ami_image_prefix" {
  type = string
}

data "aws_ami" "app_base" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["${var.aws_ami_image_prefix}-*"]
  }
}
