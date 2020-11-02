# Bucket Creation to store CFT YAML source code

resource "aws_s3_bucket" "hitech_buck" {
  bucket = "hitech-log-mgmt"
  acl    = "private"
}


# Adding CFT YAML source code into Above created S3 Bucket

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.hitech_buck.id
  key    = "log_management.yml"
  source = "/var/lib/jenkins/workspace/Jenkins-Terrafrom-CFT-pipeline/modules/log-management/CFT/log_management.yml"

}

# CLOUDFORMATION CREATION 

resource "aws_cloudformation_stack" "log_management" {
  depends_on = [aws_s3_bucket_object.object]
  name = "CFT-LOG-MANAGEMENT"
  disable_rollback = true
  parameters = {
    OperatorEmail = var.OperatorEmail
    }
 template_url = "https://${aws_s3_bucket.hitech_buck.id}.s3-us-west-2.amazonaws.com/log_management.yml"
}
