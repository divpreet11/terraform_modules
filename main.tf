
module "ec2" {
  source = "./ec2module"
  ec2_tags_public = {
    Name        = "divpreet_ec2_public"
    Environment = "Dev"
    type        = "public"
  }
  ec2_tags_private = {
    Name        = "divpreet_ec2_private"
    Environment = "Dev"
    type        = "private"
  }
  vpc_id                = module.vpc.vpc_id
  vpc_public_subnet_id  = module.vpc.vpc_subnet_public_id
  vpc_private_subnet_id = module.vpc.vpc_subnet_private_id
}



module "vpc" {
  source = "./vpcmodule"
  vpc_tags = {
    Name        = "divpreet_vpc"
    Environment = "Dev"
  }
}
