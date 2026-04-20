resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_ids
  iam_instance_profile = aws_iam_instance_profile.MongoDB-SSM-Role.name

  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name}-mongodb"
    }
  )
}
resource "aws_iam_instance_profile" "MongoDB-SSM-Role" {
  name = "MongoDB-SSM-Role"
  role = "EC2SSMParameterStore"
  }

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = local.shh_loginpass
    host = aws_instance.mongodb.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo /tmp/bootstrap.sh mongodb dev"
     ]
  }
}



# resource "aws_instance" "redis" {
#   ami           = local.ami_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [local.redis_sg_id]
#   subnet_id = local.database_subnet_ids
#   iam_instance_profile = aws_iam_instance_profile.Redis-SSM-Role.name

#   tags = merge(
#     local.common_tags,
#     {
#         Name = "${local.common_name}-redis"
#     }
#   )
# }
# resource "aws_iam_instance_profile" "Redis-SSM-Role" {
#   name = "Redis-SSM-Role"
#   role = "EC2SSMParameterStore"
#   }
# resource "terraform_data" "redis" {
#   triggers_replace = [
#     aws_instance.redis.id
#   ]

#   connection {
#     type = "ssh"
#     user = "ec2-user"
#     password = local.shh_loginpass
#     host = aws_instance.redis.private_ip
#   }

#   provisioner "file" {
#     source = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"
#   }

#   provisioner "remote-exec" {
#     inline = [ 
#         "chmod +x /tmp/bootstrap.sh",
#         "sudo /tmp/bootstrap.sh redis dev"
#      ]
#   }
# }

# resource "aws_instance" "rabbitmq" {
#   ami           = local.ami_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [local.rabbitmq_sg_id]
#   subnet_id = local.database_subnet_ids
#   iam_instance_profile = aws_iam_instance_profile.RabbitMQ-SSM-Role.name

#   tags = merge(
#     local.common_tags,
#     {
#         Name = "${local.common_name}-rabbitmq"
#     }
#   )
# }
# resource "aws_iam_instance_profile" "RabbitMQ-SSM-Role" {
#   name = "RabbitMQ-SSM-Role"
#   role = "EC2SSMParameterStore"
#   }
# resource "terraform_data" "rabbitmq" {
#   triggers_replace = [
#     aws_instance.rabbitmq.id
#   ]

#   connection {
#     type = "ssh"
#     user = "ec2-user"
#     password = local.shh_loginpass
#     host = aws_instance.rabbitmq.private_ip
#   }

#   provisioner "file" {
#     source = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"
#   }

#   provisioner "remote-exec" {
#     inline = [ 
#         "chmod +x /tmp/bootstrap.sh",
#         "sudo /tmp/bootstrap.sh rabbitmq dev"
#      ]
#   }
# }

# resource "aws_instance" "mysql" {
#   ami           = local.ami_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [local.mysql_sg_id]
#   subnet_id = local.database_subnet_ids
#   iam_instance_profile = aws_iam_instance_profile.MySQL-SSM-Role.name

#   tags = merge(
#     local.common_tags,
#     {
#         Name = "${local.common_name}-mysql"
#     }
#   )
# }
# resource "aws_iam_instance_profile" "MySQL-SSM-Role" {
#   name = "MySQL-SSM-Role"
#   role = "EC2SSMParameterStore"
#   }
# resource "terraform_data" "mysql" {
#   triggers_replace = [
#     aws_instance.mysql.id
#   ]

#   connection {
#     type = "ssh"
#     user = "ec2-user"
#     password = local.shh_loginpass
#     host = aws_instance.mysql.private_ip
#   }

#   provisioner "file" {
#     source = "bootstrap.sh"
#     destination = "/tmp/bootstrap.sh"
#   }

#   provisioner "remote-exec" {
#     inline = [ 
#         "chmod +x /tmp/bootstrap.sh",
#         "sudo /tmp/bootstrap.sh mysql dev"
#      ]
#   }
# }