variable "aws_ecr_repository_name" {
  type = string
}

resource "aws_ecr_repository" "ecr" {
  name         = var.aws_ecr_repository_name
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}
