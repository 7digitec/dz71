output "public_ips" {
  value = {
    instance_public_ip  = [for i in aws_instance.instance : i.public_ip]
  }
}

output "private_ips" {
  value = {
    instance_private_ip  = [for i in aws_instance.instance : i.private_ip]
  }
}

output "instance_ids" {
  value = {
    first_instance_public_ip  = [for i in aws_instance.instance : i.id]
  }
}

output "aws_region" {
  value = data.aws_region.current.name
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.available_zones.names
}

output "aws_vpcs" {
  value = data.aws_vpcs.all_vpcs.ids
}

