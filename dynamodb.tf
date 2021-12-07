resource "aws_dynamodb_table" "metadata_storage" {
    name = "image-metadata-storage"
    read_capacity = 1
    write_capacity = 1
    hash_key = "imageID"

    attribute {
      name = "imageID"
      type = "S"
    }
}