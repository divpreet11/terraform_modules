terraform {
  backend "s3" {
    bucket         = "divpreet-1-bucket"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "state-locking-table"
  }
}
