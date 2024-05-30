resource "aws_vpc" "vpc_for_ec2" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = var.vpc_tags
  enable_dns_hostnames = true
  enable_dns_support =true
}

resource "aws_subnet" "subnet_public" {
  vpc_id     = aws_vpc.vpc_for_ec2.id
  tags={
    Name = "public subnet",
    availability_zone = "ap-south-1a"
  }
  cidr_block = "10.0.0.0/20"
  availability_zone = "ap-south-1a"
}

resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc_for_ec2.id
  tags={
    Name = "private subnet",
    availability_zone = "ap-south-1b"
  }
  cidr_block = "10.0.128.0/20"
  availability_zone = "ap-south-1b"
}

resource "aws_internet_gateway" "igw_for_vpc" {
  vpc_id = aws_vpc.vpc_for_ec2.id
  tags = {
    Name = "igw_for_vpc"
  }
}

resource "aws_route_table" "rtb_for_public_subnet" {
  vpc_id = aws_vpc.vpc_for_ec2.id
  tags={
    Name = "rtb_for_public_subnet",
    
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_for_vpc.id
    
  }
}
resource "aws_route_table" "rtb_for_private_subnet" {
  
  vpc_id = aws_vpc.vpc_for_ec2.id
  tags={
    Name = "rtb_for_private_subnet",
  }

}


resource "aws_route_table_association" "association_for_public_subnet" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_for_public_subnet.id
}
resource "aws_route_table_association" "association_for_private_subnet" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.rtb_for_private_subnet.id
}