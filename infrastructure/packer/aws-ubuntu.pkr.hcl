variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "aws_region" {}
variable "aws_ami_image_prefix" {}

data "amazon-ami" "ubuntu-jammy" {
  filters = {
    architecture        = "x86_64"
    name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "ubuntu-ami" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "${var.aws_region}"

  ami_name      = "${var.aws_ami_image_prefix}-${local.timestamp}"
  instance_type = "t2.micro"
  source_ami    = "${data.amazon-ami.ubuntu-jammy.id}"
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu-ami"]

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    user          = "ec2-ansible-user"
  }

  # Cleanup after https://github.com/hashicorp/packer/issues/9118
  provisioner "shell" {
    inline = [
      "rm -rf /home/ubuntu/~ec2-ansible-user"
    ]
  }
}
