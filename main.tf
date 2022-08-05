resource "aws_s3_bucket" "this" {
  bucket        = var.name
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = var.acl
}

resource "aws_s3_bucket_versioning" "this" {
  count = lookup(var.versioning, "enabled", false) ? 1 : 0

  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = try(var.website["policy"], null) != null ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = var.policy
}

resource "aws_s3_bucket_logging" "this" {
  count = length(keys(var.logging)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.this.id

  target_bucket = try(var.logging["target_bucket"], null)
  target_prefix = try(var.logging["target_prefix"], null)
}

resource "aws_s3_bucket_website_configuration" "this" {
  count = length(keys(var.website)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.this.bucket

  dynamic "index_document" {
    for_each = try([var.website["index_document"]], [])

    content {
      suffix = index_document.value
    }
  }

  dynamic "error_document" {
    for_each = try([var.website["error_document"]], [])

    content {
      key = error_document.value
    }
  }

  dynamic "redirect_all_requests_to" {
    for_each = try([var.website["redirect_all_requests_to"]], [])

    content {
      host_name = try(each.value.host_name, "")
      protocol  = try(each.value.protocol, "http://")
    }
  }
}

module "objects" {
  source = "./modules/object"

  bucket     = aws_s3_bucket.this.bucket
  filepath   = var.filepath
  key_prefix = var.key_prefix
}


