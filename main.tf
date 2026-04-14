resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_ids
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name}-mongodb"
    }
  )
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
    source = "boostrap.sh"
    destination = "/tmp/boostrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/boostrap.sh",
        "sudo /tmp/boostrap.sh mongodb"
     ]
  }
}


resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id = local.database_subnet_ids
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name}-redis"
    }
  )
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = local.shh_loginpass
    host = aws_instance.redis.private_ip
  }

  provisioner "file" {
    source = "boostrap.sh"
    destination = "/tmp/boostrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/boostrap.sh",
        "sudo /tmp/boostrap.sh redis"
     ]
  }
}

resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  subnet_id = local.database_subnet_ids
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name}-rabbitmq"
    }
  )
}

resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = local.shh_loginpass
    host = aws_instance.rabbitmq.private_ip
  }

  provisioner "file" {
    source = "boostrap.sh"
    destination = "/tmp/boostrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /tmp/boostrap.sh",
        "sudo /tmp/boostrap.sh rabbitmq"
     ]
  }
}

# resource "aws_instance" "mysql" {
#   ami           = local.ami_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = [local.mysql_sg_id]
#   subnet_id = local.database_subnet_ids
#   tags = merge(
#     local.common_tags,
#     {
#         Name = "${local.common_name}-mysql"
#     }
#   )
# }

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
#     source = "boostrap.sh"
#     destination = "/tmp/boostrap.sh"
#   }

#   provisioner "remote-exec" {
#     inline = [ 
#         "chmod +x /tmp/boostrap.sh",
#         "sudo /tmp/boostrap.sh mysql"
#      ]
#   }
# }