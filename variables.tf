variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "Choose CIDR for vpc"
  type        = string
}

variable "region" {
  default     = "ap-south-1"
  description = "Choose region for your stack"
  type        = string
}


variable "ami_ids"{
  default = {
    ap-south-1 = "ami-0d9462a653c34dab7"
    ap-southeast-1 = "ami-0f02b24005e4aec36"
  }
}