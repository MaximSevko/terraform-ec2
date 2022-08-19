module "ec2" {
    source = "../../"
  
    name = var.ec2_name
  
    instance_type               = "t4g.micro"
    availability_zone           = local.availability_zone
    subnet_id                   = element(module.vpc.public_subnets, 0)
    vpc_security_group_ids      = [module.security_group.security_group_id]
    associate_public_ip_address = true
  
    tags = var.ec2_tags
  }

  resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = module.ec2.id
}

resource "aws_ebs_volume" "this" {
  availability_zone = local.availability_zone
  size              = 1

  tags = var.volume_tags
}
