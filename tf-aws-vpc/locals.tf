locals {

  azs = length(var.azs) != 0 ? var.azs : [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1], data.aws_availability_zones.available.names[2]]

  tags = merge(
    var.tags,
    {
      terraform = true
      env       = "${var.env}"
    }
  )
}
