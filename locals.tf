locals {
  common_tags = {
    Project_name = var.project_name
    Env = var.env
    Terraform = "true"
  }
  common_name = ("${var.project_name}-${var.env}")
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  ami_id = data.aws_ami.roboshop_ami.id
  database_subnet_ids = split(",",data.aws_ssm_parameter.database_subnet_ids.value)[0]
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value

}