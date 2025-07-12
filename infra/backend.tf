terraform {
  backend "remote" {
    organization = "smriti-aws"
    workspaces {
      name = "automated-testing"
    }
  }
}
