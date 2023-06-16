resource "random_id" "RAILS_MASTER_KEY" {
  byte_length = 16
}

resource "aws_ssm_parameter" "RAILS_MASTER_KEY" {
  name  = "/app/RAILS_MASTER_KEY"
  type  = "SecureString"
  value = random_id.RAILS_MASTER_KEY.hex
}

resource "random_id" "SECRET_KEY_BASE" {
  byte_length = 64
}

resource "aws_ssm_parameter" "SECRET_KEY_BASE" {
  name  = "/app/SECRET_KEY_BASE"
  type  = "SecureString"
  value = random_id.SECRET_KEY_BASE.hex
}
