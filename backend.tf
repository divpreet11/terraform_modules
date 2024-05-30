terraform {
  backend "s3" {
    bucket         = "divpreet-new-bucket"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "div-state-locking-table"
  }
}
