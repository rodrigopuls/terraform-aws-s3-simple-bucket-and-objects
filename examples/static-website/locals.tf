locals {
  domain = "test-url.com"
  bucket_policy = templatefile("policy.json.tftpl", {
    bucket_name = local.domain
  })
}