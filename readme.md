# GBrembati Azure VNet Modules
This Terraform project is intended to be used as module for the creation of multiple (or single) VNets with multiple (or single) subnets.
Please refer to the indication in https://registry.terraform.io/modules/gbrembati/azure-vnet/module to learn more.

## How to use it
You would need to call the module within your main code, providing the needed variables, e.g. :

```hcl
module "vnet-spokes" {
  source  = "gbrembati/azure-vnet/module"
  version = "1.2.2" 

  location      = "France Central"

  subnets-per-vnet  = 3
  cidr-spokes   = {
    "0" = ["10.0.0.0/22","10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
    "1" = ["10.0.4.0/22","10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
  # "2" = ["<vnet-cidr>","<subnet-A-cidr>","<subnet-B-cidr>","<subnet-C-cidr>"]
  }
  name-spokes   = {
    "0" = ["spoke-A","frontend","backend","application"]
    "1" = ["spoke-B","frontend","backend","application"]   
  # "2" = ["<vnet-name>","<subnet-A-name>","<subnet-B-name>","<subnet-C-name>"] 
  } 
  
  deployment-tags   = {
    owner       = "administrator"
    managed-by  = "terraform-cloud"
  }
}
```