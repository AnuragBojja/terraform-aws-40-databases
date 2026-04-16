data "aws_ami" "roboshop_ami" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "shh_loginpass" {
  name = "/roboshop/${var.env}/shh/loginpass"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.env}/vpc_id"
}
#### DATABASES ###
data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project_name}/${var.env}/mongodb_sg_id"
}
data "aws_ssm_parameter" "redis_sg_id" {
  name = "/${var.project_name}/${var.env}/redis_sg_id"
}
data "aws_ssm_parameter" "rabbitmq_sg_id" {
  name = "/${var.project_name}/${var.env}/rabbitmq_sg_id"
}
data "aws_ssm_parameter" "mysql_sg_id" {
  name = "/${var.project_name}/${var.env}/mysql_sg_id"
}

#### BACKEND ####
data "aws_ssm_parameter" "cart_sg_id" {
  name = "/${var.project_name}/${var.env}/cart_sg_id"
}
data "aws_ssm_parameter" "catalogue_sg_id" {
  name = "/${var.project_name}/${var.env}/catalogue_sg_id"
}
data "aws_ssm_parameter" "user_sg_id" {
  name = "/${var.project_name}/${var.env}/user_sg_id"
}
data "aws_ssm_parameter" "payment_sg_id" {
  name = "/${var.project_name}/${var.env}/payment_sg_id"
}
data "aws_ssm_parameter" "shipping_sg_id" {
  name = "/${var.project_name}/${var.env}/shipping_sg_id"
}

#### SUBNETS ####
data "aws_ssm_parameter" "database_subnet_ids" {
  name = "/${var.project_name}/${var.env}/database_subnet_ids"
}
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.env}/public_subnet_ids"
}
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.env}/private_subnet_ids"
}
