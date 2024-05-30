output "ec2_output" {
  value = module.ec2.ec2_ssh_key

}

# output "s3_root_module_output" {
#   value = module.s3_bucket.s3bucket1output
# }

# output "vpc_output" {
#   value = module.vpc.vpc_info
# }