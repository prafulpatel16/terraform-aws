provider "aws" {
  region = var.aws_region
}


resource "aws_db_instance" "rds-demo" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
#  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = ["${aws_security_group.db_security_group.id}"]
  skip_final_snapshot  = true

  tags = {
    Name = var.db_name
  }
}
output "rds_endpoint" {
  value = aws_db_instance.rds-demo.endpoint
}


resource "aws_security_group" "db_security_group" {
  name        = "db_security_group"
  description = "Allow incoming database traffic"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# provide aws key pair for EC2 machine

resource "aws_key_pair" "key" {
  key_name   = "test-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Create EC2 machine

resource "aws_instance" "webserver" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]

  depends_on = [aws_instance.webserver]

}

# Null resource block to provide files from local to remote machine

#Create SG for allowing TCP/80 & TCP/22
resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow TCP/80 & TCP/22"
  vpc_id      = var.vpc
  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow traffic from TCP/80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#-----  RDS Login ---------------------

resource "null_resource" "file_execute" {
  # To copy the file from local to remote machine
  provisioner "file" {
    source      = "obbs.sql"
    destination = "/tmp/obbs.sql"
  }

  provisioner "file" {
    source      = "connect_to_rds.sh"
    destination = "/tmp/connect_to_rds.sh"
  }
  connection {
    type        = "ssh"
    host        = aws_instance.webserver.public_ip
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
  }

    provisioner "remote-exec" {
    inline = [
        "sudo yum install -y mysql" # Install MySQL client
    ]
    connection {
        type        = "ssh"
        host        = aws_instance.webserver.public_ip
        user        = "ec2-user"
        private_key = file("~/.ssh/id_rsa")
}

}
    
}


#---- RDS host login ----
/*
resource "null_resource" "rds_login" {
  triggers = {
    rds_endpoint = aws_db_instance.rds-demo.endpoint
  }


  provisioner "local-exec" {
    command = "chmod +x ${path.module}/connect_to_rds.sh && ${path.module}/connect_to_rds.sh '${aws_db_instance.rds-demo.endpoint}' '/tmp/obbs.sql'"
  }


  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "chmod +x /tmp/connect_to_rds.sh",
      "sh. /tmp/connect_to_rds.sh",
    ]

    connection {
    type        = "ssh"
    host        = aws_instance.webserver.public_ip
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
}
  }
}

*/

resource "null_resource" "rds_login" {
  triggers = {
    rds_endpoint = aws_db_instance.rds-demo.endpoint
  }

  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "chmod +x /tmp/connect_to_rds.sh",  # Ensure the script is executable
      # 
      "/tmp/connect_to_rds.sh '${aws_db_instance.rds-demo.endpoint}' '/tmp/obbs.sql'",
    ]

    connection {
      type        = "ssh"
      host        = aws_instance.webserver.public_ip
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}
