provider "aws" {
  shared_config_files      = ["${path.module}/packer/build_artifacts/.aws/config"]
  shared_credentials_files = ["${path.module}/packer/build_artifacts/.aws/credentials"]
}
