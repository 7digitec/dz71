data "aws_region" "current" {}
data "aws_availability_zones" "available_zones" {
  state = "available"
}
data "aws_vpcs" "all_vpcs" {}
