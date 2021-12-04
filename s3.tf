#New bucket
resource "aws_s3_bucket" "my_triggering_bucket" {
  bucket = "ta-632-lambda-triggering"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "ta-lambda2-lab"
    Environment = "Test"
  }
}



