variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_public_subnets_cidr_block" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "company" {
  type    = string
  default = "MyCompany"
}

variable "project" {
  type    = string
  default = "Web Server"
}

variable "naming_prefix" {
  type    = string
  default = "WebServer"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "instance_key" {
  default = "MyKey"
}