# AWS S3 Object Terraform module

Terraform module to handle S3 bucket objects resources on AWS.

These types of resources are supported:

* [S3 Object](hhttps://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)

## Usage

```hcl
module "bucket" {
  source = "github.com/rodrigopuls/terraform-s3-simple-bucket-and-objects/modules/object"
  
  bucket     = aws_s3_bucket.this.bucket
  filepath   = var.filepath
  key_prefix = var.key_prefix
}
```

## Examples



## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.6 |
| aws | >= 4.24.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|bucket|Bucket unique name|`string`|`null`| ✅ |
|filepath|string|`string`|`null`| ✅ |
|key_prefix|Prefix to put your key(s) inside the bucket. E.g.: logs -> all files will be uploaded under logs/|`string`||  |

## Outputs

| Name | Description |
|------|-------------|
|objects|Set of objects created on the given S3 bucket|

## Authors

Module managed by [Rodrigo Puls](https://github.com/rodrigopuls)

## License
[MIT](LICENSE)