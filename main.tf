provider "aws" {
  region = var.aws_region
}

#fetch information about a lambda IAM role
data "aws_iam_role" "fetch_lambda_role" {
  name = "lambda-practice1"
}


#IAM Policy for lambda 
# resource "aws_iam_policy" "lambda_practice2_policy" {
#   name = "lambda-practice2-policy"

#   policy = jsonencode({
#     "Version" = "2012-10-17"
#     "Statement" = [
#       {
#         "Sid" : "ListBuckets",
#         "Effect" : "Allow",
#         "Action" : ["s3:ListAllMyBuckets"],
#         "Resource" : "*"
#       },
#       {
#         "Sid" : "s3access",
#         "Action" : [
#           "s3:ListBucket",
#           "s3:*Object",
#         ],
#         "Effect" : "Allow",
#         "Resource" : [
#           "arn:aws:s3:::ta-632-lambda-triggering",
#           "arn:aws:s3:::ta-632-lambda-triggering/*"
#         ]
#       },
#       {
#         "Action" : [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ],
#         "Effect" : "Allow",
#         "Resource" : "*"
#       },
#       {
#         "Action" : [
#           "dynamodb:BatchGetItem",
#           "dynamodb:GetItem",
#           "dynamodb:Query",
#           "dynamodb:Scan",
#           "dynamodb:BatchWriteItem",
#           "dynamodb:PutItem",
#           "dynamodb:UpdateItem"
#         ],
#         "Effect" : "Allow",
#         "Resource" : "arn:aws:dynamodb:::image-metadata-storage"
#       }
#     ]
#   })
# }

# #Attach IAM Role and policies
# resource "aws_iam_role_policy_attachment" "test-attach" {
#   role       = data.aws_iam_role.fetch_lambda_role.name
#   policy_arn = aws_iam_policy.lambda_practice2_policy.arn
# }




#Data source to zip lambda
# data "archive_file" "my_lambda_store_function" {
#   source_dir  = "${path.module}/lambda/"
#   output_path = "${path.module}/lambda.zip"
#   type        = "zip"
# }

# #Lambda function
# resource "aws_lambda_function" "store_function" {
#   filename         = "lambda.zip"
#   source_code_hash = data.archive_file.my_lambda_store_function.output_base64sha256
#   function_name    = "store_metadata"
#   role             = data.aws_iam_role.fetch_lambda_role.arn
#   handler          = "store_metadata.lambda_handler"
#   runtime          = "python3.8"
# }







