resource "aws_dynamodb_table" "metadata_storage" {
    name = "image-metadata-storage"
    hash_key = "imageID"

    attribute {
      name = "imageID"
      type = "S"
    }
}