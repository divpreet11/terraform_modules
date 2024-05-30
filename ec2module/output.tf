# output "ec2_output" {
#     value = aws_instance.aws_ec2.arn
# }
output "ec2_ssh_key" {
  value = aws_key_pair.ssh_key.arn
}
