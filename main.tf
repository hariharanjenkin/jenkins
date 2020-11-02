provider "aws" {
  version = "~> 2.0"
  region  = "us-west-2"
}


module "log-management"{
  source = "./modules/log-management"
  OperatorEmail = var.OperatorEmail
}
