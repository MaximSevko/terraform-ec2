module "ec2" {
    source = "../../"
  
    name = var.ec2_name
  
    ami = data.aws_ami.amazon_linux.id
    instance_type               = "t4g.micro"
    availability_zone           = element(module.vpc.azs, 0)
    subnet_id                   = element(module.vpc.public_subnets, 0)
    vpc_security_group_ids      = [module.security_group.security_group_id]
    associate_public_ip_address = true
    key_name = "amikey"
    root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      volume_size = 10
      tags = {
        Name = "my-root-block"
      }
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdb"
      volume_type = "gp3"
      volume_size = 3
      encrypted   = true
      kms_key_id  = aws_kms_key.this.arn
    },
    {
      device_name = "/dev/sdc"
      volume_type = "gp3"
      volume_size = 2
      encrypted   = true
      kms_key_id  = aws_kms_key.this.arn
    }
  ]



    tags = var.ec2_tags
  }

#  resource "aws_volume_attachment" "this" {
#  device_name = "/dev/sdh"
#  volume_id   = aws_ebs_volume.this.id
#  instance_id = module.ec2.id
#}
#
#resource "aws_ebs_volume" "disk1" {
#  availability_zone = local.availability_zone
#  size              = 2
#
#  tags = var.volume_tags
#}
#
#resource "aws_kms_key" "this" {
#}
