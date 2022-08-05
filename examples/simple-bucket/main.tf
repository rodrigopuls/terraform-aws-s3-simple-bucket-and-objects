module "bucket" {
  source = "github.com/rodrigopuls/terraform-s3-simple-bucket-and-objects"
  name   = "this-is-a-test-bucket-${timestamp()}"
}

output "arn" {
  value = module.bucket.arn
}
