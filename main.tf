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
    password = "DevOps321"
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