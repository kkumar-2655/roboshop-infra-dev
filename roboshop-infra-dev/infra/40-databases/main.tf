resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mongodb"
    }
  )
}

resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

  provisioner "remote-exec" {
  inline = [
    # Enable EPEL and install ansible-core on RHEL 9
    "sudo dnf install -y epel-release",
    "sudo dnf install -y ansible-core",
    
    # Print ansible version to confirm it's installed
    "ansible --version",
    
    # Fix script line endings and execute
    "sed -i 's/\\r//' /tmp/bootstrap.sh",
    "chmod +x /tmp/bootstrap.sh",
    "sudo sh /tmp/bootstrap.sh mongodb"
  ]
}
}

resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-redis"
    }
  )
}

resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

  provisioner "remote-exec" {
  inline = [
    # Enable EPEL and install ansible-core on RHEL 9
    "sudo dnf install -y epel-release",
    "sudo dnf install -y ansible-core",
    
    # Print ansible version to confirm it's installed
    "ansible --version",
    
    # Fix script line endings and execute
    "sed -i 's/\\r//' /tmp/bootstrap.sh",
    "chmod +x /tmp/bootstrap.sh",
    "sudo sh /tmp/bootstrap.sh redis"
  ]
}
}

resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id = local.database_subnet_id
  iam_instance_profile = "RoleToFetchSSMParams" # Ensure this role is created in the IAM module

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mysql"
    }
  )
}

resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mysql.private_ip
  }

  provisioner "remote-exec" {
  inline = [
    # Enable EPEL and install ansible-core on RHEL 9
    "sudo dnf install -y epel-release",
    "sudo dnf install -y ansible-core",
    
    # Print ansible version to confirm it's installed
    "ansible --version",
    
    # Fix script line endings and execute
    "sed -i 's/\\r//' /tmp/bootstrap.sh",
    "chmod +x /tmp/bootstrap.sh",
    "sudo sh /tmp/bootstrap.sh mysql"
  ]
}
}

resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  subnet_id = local.database_subnet_id

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-rabbitmq"
    }
  )
}

resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]
  
  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.rabbitmq.private_ip
  }

  provisioner "remote-exec" {
  inline = [
    # Enable EPEL and install ansible-core on RHEL 9
    "sudo dnf install -y epel-release",
    "sudo dnf install -y ansible-core",
    
    # Print ansible version to confirm it's installed
    "ansible --version",
    
    # Fix script line endings and execute
    "sed -i 's/\\r//' /tmp/bootstrap.sh",
    "chmod +x /tmp/bootstrap.sh",
    "sudo sh /tmp/bootstrap.sh rabbitmq"
  ]
 }
}
