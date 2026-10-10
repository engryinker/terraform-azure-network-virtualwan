terraform {
  required_version = ">= 1.7.0"
}

module "virtualwan" {
  source = "../.."

  resource_group_name = "rg-example"
  location            = "eastus"
  tags = {
    environment = "dev"
  }

  virtual_wans = {} # see README Inputs table for the per-entry schema
  virtual_hubs = {}
}
