variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
  default     = "mydb"
}

variable "db_username" {
  description = "RDS database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS database password"
  type        = string
  default     = "password"
}
variable "db_port" {
  description = "Name of the RDS database"
  type        = string
  default     = "3306"
}

variable "sql_dump_path" {
  description = "Path to the .sql database dump file"
  type        = string
  default     = "obbs.sql"
}

# AMI Variable
variable "ami" {
  description = "Variable for EC2 instance AMI"
  type        = string
  default     = "ami-0b0dcb5067f052a63" 
}
# Instance Type variable
variable "instance_type" {
  description = "Variable for EC2 instance type"
  type        = string
  default     = "t2.micro"
}
# VPC variable
variable "vpc" {
  description = "Variable for VPC"
  type        = string
  default     = "vpc-0588748c5167e7938"
}
variable "rds_host" {
  type    = string
  default = "localhost" # Set your desired default value
}