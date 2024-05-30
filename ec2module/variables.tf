variable "ec2_tags_public" {
    type=map(string)
    description="Map of ec2 tags for public" 
     
}
variable "ec2_tags_private" {
    type=map(string)
    description="Map of ec2 tags for private" 
     
}
variable "vpc_id"{
    type=string
    description="Vpc id to receive form vpc"
}
variable "vpc_public_subnet_id"{
    type=string
    description="public subnet in vpc id"
}
variable "vpc_private_subnet_id"{
    type=string
    description="private subnet in vpc id"
}