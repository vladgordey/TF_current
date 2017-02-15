# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

data "aws_availability_zones" "available" {}

module "my_vpc" {
    source = "github.com/vladgordey/TF_VPC_mod"
	vpc_cidr = "${var.vpc_cidr}"
	short_name ="${var.short_name}"
	az_count ="${var.az_count}"
}

module "my_sg" {
    source = "github.com/vladgordey/TF_SecG_mod"
	vpc_id = "${module.my_vpc.vpc_id}"
	short_name ="${var.short_name}"
}

module "my_elb" {
    source = "github.com/vladgordey/TF_ELB_mod"
	sec_group = "${module.my_sg.elb_sg}"
	subnets = ["${module.my_vpc.subnets}"]
}

module "my_asg" {
     source = "github.com/vladgordey/TF_ASG_mod"
	 lc_name = "${var.lc_name}"
     ami_id = "${var.ami_id}"
     instance_type = "${var.instance_type}"
     iam_instance_profile = "${var.iam_instance_profile}"
     key_name = "${var.key_name}"
     security_group = "${module.my_sg.elb_sg}"
     user_data = "${var.user_data_file}"
     asg_name = "${var.asg_name}"
     asg_number_of_instances = "${var.asg_number_of_instances}"
     asg_minimum_number_of_instances = "${var.asg_minimum_number_of_instances}"
     load_balancer_names = "${module.my_elb.elb_id}"
     health_check_type = "${var.health_check_type}"
     availability_zones = "${data.aws_availability_zones.available.names[count.index]}"
     vpc_zone_subnets = ["${module.my_vpc.subnets}"]
}

module "my_rds" {
    source = "github.com/vladgordey/TF_RDS_mod"
rds_instance_name="${var.short_name}-RDS"
rds_is_multi_az="${var.rds_is_multi_az}"
rds_storage_type="${var.rds_storage_type}"
rds_allocated_storage="${var.rds_allocated_storage}"
rds_engine_type="${var.rds_engine_type}"
rds_engine_version="${var.rds_engine_version}"
rds_instance_class="${var.rds_instance_class}"
database_name="${var.database_name}"
database_user="${var.database_user}"
database_password="${var.database_password}"
rds_security_group_id="${var.rds_security_group_id}"
db_parameter_group="${var.db_parameter_group}"
publicly_accessible="${var.publicly_accessible}"
subnet_az1="${module.my_vpc.subnet_0}"
subnet_az2="${module.my_vpc.subnet_1}"
}
