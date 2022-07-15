terraform {
  backend "s3" {
    bucket = "b-mybucket1"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "locktable"
  }
}