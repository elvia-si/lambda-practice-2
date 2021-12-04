#EventBridge SNS notification
resource "aws_cloudwatch_event_rule" "S3_upload_notification" {
  name        = "capture-s3-object-upload"
  description = "Capture each object upload in s3 bucket"

  event_pattern = <<EOF
{
  "detail-type": [
    "AWS s3 object upload via CloudTrail"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.S3_upload_notification.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.object_upload.arn
}

resource "aws_sns_topic" "object_upload" {
  name = "aws-s3-object-upload"
}


resource "aws_sns_topic_policy" "default" {
  arn    = aws_sns_topic.object_upload.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.object_upload.arn]

    # condition = {
    #   test     = "ArnLike"
    #   variable = "aws:SourceArn"
    #   values = [
    #     "${aws_s3_bucket.triggering_bucket.arn}"
    #   ]
    # }
  }
}

#EventBridge notification for S3

resource "aws_s3_bucket_notification" "object_create_sns" {
  bucket = aws_s3_bucket.my_triggering_bucket.id

  topic {
    topic_arn     = aws_sns_topic.object_upload.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
}

# #s3 permission to trigger lambda
# resource "aws_lambda_permission" "allow_bucket_trigger" {
#    statement_id = "AllowExecutionFromS3Bucket"
#    action = "lambda:InvokeFunction"
#    function_name = aws_lambda_function.store_function.function_name
#    principal = "s3.amazonaws.com"
#    source_arn = "arn:aws:s3:::ta-632-lambda-triggering"
# }

#allow sns to trigger lambda
resource "aws_lambda_permission" "allow_sns_trigger_lambda" {
  statement_id  = "AllowExecutionFromSNS"
  function_name = aws_lambda_function.store_function.function_name
  action        = "lambda:InvokeFunction"
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.object_upload.arn
}

