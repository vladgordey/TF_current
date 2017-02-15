variable "vpc_cidr" {default = "10.10.0.0/16"}
variable "short_name" {default = "gordey"}
variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

############### ASG
variable "lc_name" {
  default     = "my_lc"
  }
variable "ami_id" {
  description = "ami_id"
  default     = "ami-cbdc17a4"
}
variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}
variable "iam_instance_profile" {
  default     = "S3_RDS_role"
  description = "The IAM role the launched instance will usee"
}
variable "key_name" {
  default     = "Linux_EC2_Terraform"
  description = "Name of the SSH keypair to use in AWS."
}
variable "user_data_file" {
 default = "user-data.sh"
}
variable "asg_name" {
  default = "my-custom-asg"
}
variable "asg_number_of_instances" {
  default = 2
}
variable "asg_minimum_number_of_instances" {
  default = 1
}

variable "health_check_type" {
  default = "ELB"
}

############ RDS
variable "rds_is_multi_az" {
    default = "true"
}
variable "rds_storage_type" {
    default = "standard"
}
variable "rds_allocated_storage" {
	default = "10"
    description = "The allocated storage in GBs"
}
variable "rds_engine_type" {
default = "mysql"
}
variable "rds_engine_version" {
default = "5.7.11"
}
variable "rds_instance_class" {
default = "db.t1.micro"
}
variable "database_name" {
default = "gordey_dbase"
    description = "The name of the database to create"
}
variable "database_user" {
default = "gordey"
}
variable "database_password" {
default = "password"
}

variable "db_parameter_group" {
    default = "default.mysql5.6"
}
variable "publicly_accessible" {
    default = "false"
}


