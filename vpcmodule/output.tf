
output "vpc_id" {
    value = aws_vpc.vpc_for_ec2.id
  
}
output "vpc_subnet_public_id" {
    value = aws_subnet.subnet_public.id
  
}
output "vpc_subnet_private_id" {
    value = aws_subnet.subnet_private.id
  
}
