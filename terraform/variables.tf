variable "project_name" {
  type    = string
  default = "trend"
}

variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_a" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr_b" {
  type    = string
  default = "10.0.2.0/24"
}

variable "availability_zone_a" {
  type    = string
  default = "eu-north-1a"
}

variable "availability_zone_b" {
  type    = string
  default = "eu-north-1b"
}

variable "allowed_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name"
}
