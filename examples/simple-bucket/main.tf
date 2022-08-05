module "bucket" {
  source = "github.com/rodrigopuls/terraform-aws-s3-simple-bucket-and-objects"
  name   = "this-is-a-test-bucket-${uuid()}"
}

output "arn" {
  value = module.bucket.arn
}
