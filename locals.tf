locals {
  common_tags = {
    Project_name = var.project_name
    Env = var.env
    Terraform = "true"
  }
  common_name = ("${var.project_name}-${var.env}")
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  ami_id = data.aws_ami.roboshop_ami.id
  shh_loginpass = data.aws_ssm_parameter.shh_loginpass.value
  database_subnet_ids = split(",",data.aws_ssm_parameter.database_subnet_ids.value)[0]

  ### DATABASES
  mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
  rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
  #### BACKEND ###
  cart_sg_id = data.aws_ssm_parameter.cart_sg_id.value
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
  user_sg_id = data.aws_ssm_parameter.user_sg_id.value
  shipping_sg_id = data.aws_ssm_parameter.shipping_sg_id.value
  payment_sg_id = data.aws_ssm_parameter.payment_sg_id.value
  zone_id = data.aws_route53_zone.zone.zone_id
  

}