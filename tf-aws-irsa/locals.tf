locals {
  tags = merge(
    var.tags,
    {
      terraform = true
      env       = "${var.env}"
    }
  )
}
