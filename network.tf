resource "aws_default_subnet" "def_subnet" {
  count             = length(data.aws_availability_zones.available_zones.names)
#  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  availability_zone = data.aws_availability_zones.available_zones.names[1]
}
