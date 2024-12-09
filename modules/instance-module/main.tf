resource "instance" "test" {
  name          = var.name
  instance_type = var.instance_type
  vpc_id        = var.vpc_id
}