terraform {
  required_version = "1.2.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.24.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
  }
}

module "logs" {
  source = "github.com/rodrigopuls/terraform-s3-simple-bucket-and-objects"

  name = "${local.domain}-logs"
  acl  = "log-delivery-write"
}

module "website" {
  source = "github.com/rodrigopuls/terraform-s3-simple-bucket-and-objects"

  name   = random_pet.this.id
  acl    = "public-read"
  policy = local.bucket_policy

  filepath = "${path.root}/../website"

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