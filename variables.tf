variable "region" {
  description = "aws region"
  default     = "eu-central-1"
}

variable "instances_count" {
  type        = number
  description = "Number of EC2 instances to create"
  default     = 1
}
variable "instance_root_volume_size" {
  type        = number
  description = "Volumen size of root"
}

variable "instance_data_volume_size" {
  type        = number
  description = "Volumen size of instance"
}

variable "instance_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen.(gp3, gp2, io1, sc1, st1)"
  default     = "gp2"
}
variable "ingress_ports" {
  type        = list(any)
  description = "allowed incoming ports"
  default     = ["22", "80", "443", "3000"]
}

variable "instance_type" {
  type        = string
  description = "instance type"
  default     = "t2.micro"
}

variable "instance_ami_id" {
  description = "instance ami id"
  default     = "ami-04e601abe3e1a910f"
}

variable "app_environment" {
  type        = string
  description = "instance environment"
  default     = "Production"
}

variable "instance_subnet_id" {
  description = "instance subnet id"
  default     = "subnet-075afc9b53eb1cc02"
}

variable "instance_create_volume" {
  default = "1"
}

variable "instance_ebs_volume_size" {
  description = "instance ebs volume size"
  default     = "100"
}

variable "instance_ebs_volume_type" {
  description = "instance ebs volume type"
  default     = "gp2"
}

variable "instance_device_name1" {
  description = "instance device name"
  default     = "/dev/xvdf" 
}

variable "instance_device_name2" {
  description = "instance device name"
  default     = "/dev/xvdg" 
}

variable "instance_key_name" {
  description = "instance key name"
  default     = "testkey2"
}
