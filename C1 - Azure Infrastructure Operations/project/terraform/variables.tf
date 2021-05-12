#Main variables
variable "prefix" {
    description = "The prefix which should be used for all resources in this example."
    default = "udacity-proj"
}

variable "tags" {
    type = map
    default = {
        Environment = "dev-env"
        Project     = "uda-proj"
        }
}

variable "VMnum" {
    description = "Number of VM resources to be created behind the load balancer."
    default = 2
}

#Network variables
variable "admin_username" {
    description = "VM Admin User"
}

variable "admin_password" {
      description = "VM Admin Password"
}

variable "location" {
  description = "The Azure Region in which all resources should be created."
  default = "germanywestcentral"
}