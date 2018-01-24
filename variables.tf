variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}


# Choose an Availability Domain
variable "AD" {
  default = "1"
}

variable "InstanceShape" {
  default = "VM.Standard1.1"
}

variable "instance_count" {
  default=3
}

variable "InstanceImageDisplayName" {
    default = "Oracle-Linux-7.4-2017.10.25-0"
}


#Chef Configuration Variables

variable "chef_user" {
  description = "User name to access your Chef server"
}
variable "chef_key" {
  description = "Path to Private Key for your chef_user to access Chef server"
}


variable "chef_recipes" {
  description = "List of recipes for Chef to run"
  type = "list"
}

variable "chef_server" {
  description = "URL for your chef server"
}


