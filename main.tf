provider "aws" {
  region = var.region
}

resource "aws_instance" "instance" {
  ami                    = var.instance_ami_id
  instance_type          = var.instance_type
  key_name               = var.instance_key_name
  vpc_security_group_ids = [aws_security_group.SG1.id]
  subnet_id              = var.instance_subnet_id
  count                  = length(data.aws_availability_zones.available_zones.names)
  availability_zone      = data.aws_availability_zones.available_zones.names[count.index]

  # root disk
  root_block_device {
    volume_size           = var.instance_root_volume_size
    volume_type           = var.instance_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name        = "${var.app_environment}-instance-${count.index+1}"
    Environment = var.app_environment
    Name       = "instance_{instances_count.index+1}"
    Env        = "production"
    ServerType = "backend"
  }


  user_data = templatefile("01-ssh-public-key-config.tpl", { key_owner = "digitec@HP" })

}


resource "aws_ebs_volume" "ssdgp1" {
  count                 = length(data.aws_availability_zones.available_zones.names)
  availability_zone     = data.aws_availability_zones.available_zones.names[count.index]
  size                  = var.instance_ebs_volume_size
  type                  = var.instance_ebs_volume_type

#  kms_key_id = "Optional"
  tags = {
    Name       = "ssdgp1"
    Env        = "production"
    Size       = "100 Gb"
  }
}

resource "aws_volume_attachment" "ssdgp1" {

  count             = length(data.aws_availability_zones.available_zones.names)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  device_name           = var.instance_device_name1
  volume_id             = aws_ebs_volume.ssdgp1.id
  instance_id           = aws_instance.instance[count.index].id

#  device_name = "/dev/xvdf"
#  instance_id = "aws_instance.instance.id"
#  volume_id = "aws_ebs_volume.ssdgp1.id"
#  volume_id = "${aws_ebs_volume.id}"
#  force_detach = "Optional"
#  skip_destroy = "Optional"
}


resource "aws_security_group" "SG1" {
  name        = "SG1"
  description = "Open ports: 22, 80, 443, 3000"
  vpc_id      = aws_default_vpc.default_vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_default_vpc" "default_vpc" {
   tags = {
        Name = "Default VPC"
   }
}
