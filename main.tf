provider "aws" {
  version = "~> 2.0"
  region  = var.region
}


module "log-management"{
  source = "./modules/log-management"
  OperatorEmail = var.OperatorEmail
}
