variable "tags" {
  description = "Common set of tags."
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "Environment"
  type        = string
  default     = ""
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "Vpc name"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "azs" {
  description = "A list of availability zones names or ids in the region. If empty, defaults to first three available zones."
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "List of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "List of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "List of database subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "map_public_ip_on_launch" {
  description = "Should be true if you want to auto-assign public IP on launch"
  type        = bool
  default     = false
}
