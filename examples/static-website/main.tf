terraform {
  required_version = "1.2.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.24.0"
    }
  }
}

module "logs" {
  source = "github.com/rodrigopuls/terraform-aws-s3-simple-bucket-and-objects"

  force_destroy = true
  name          = "${local.domain}-logs"
  acl           = "log-delivery-write"
}

module "website" {
  source = "github.com/rodrigopuls/terraform-aws-s3-simple-bucket-and-objects"

  name   = local.domain
  acl    = "public-read"
  policy = templatefile("policy.json.tftpl", {
    bucket_name = local.domain
  })

  filepath = "${path.root}/website"

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  versioning = {
    enabled = true
  }

  logging = {
    target_bucket = module.logs.name
    target_prefix = "access/"
  }
}

module "redirect" {
  source = "github.com/rodrigopuls/terraform-aws-s3-simple-bucket-and-objects"

  name = "www.${local.domain}"
  acl  = "public-read"

  website = {
    redirect_all_requests_to = local.domain
    protocol                 = "https"
  }
}