terraform {
  backend "s3" {
    bucket         = "talent-academy-954444250632-tfstates"
    key            = "sprint2/lambda-training2/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}