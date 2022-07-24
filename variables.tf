variable "location" {
  description = "Used to set deployment location"
  default = "France Central"
}
variable "name-spokes" {
  description = "provide cidr of spokes"
  default = {
    "0" = ["spoke-A","frontend","backend","application"]
    "1" = ["spoke-B","frontend","backend","application"]   
  # "2" = ["spoke-C","frontend","backend","application"] 
  } 
}
variable "name-spokes" {
  description = "provide names of spokes"
  default = {
    "0" = ["10.0.0.0/22","10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
    "1" = ["10.0.4.0/22","10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
  # "2" = ["10.0.8.0/22","10.0.8.0/24","10.0.9.0/24","10.0.10.0/24"]
  }
}