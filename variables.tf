variable "name" {
  description = "Bucket unique name. It can contain only number, letter and dash."
  type        = string
}

variable "acl" {
  description = "Access Control Lists. It defines which AWS accounts or groups are granted access and the type of access."
  type        = string
  default     = "private"
}

variable "attach_policy" {
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
  type        = bool
  default     = false
}

variable "policy" {
  description = "A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Whether or not to force destroy the bucket."
  type        = bool
  default     = false
}

variable "website" {
  description = "Map containing website configs."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Bucket tags"
  type        = map(string)
  default     = {}
}

variable "key_prefix" {
  description = "Prefix to put your key(s) inside the bucket. E.g.: logs -> all files will be uploaded under logs."
  type        = string
  default     = ""
}

variable "filepath" {
  description = "The local path containing the file(s) to be uploaded."
  type        = string
  default     = ""
}

variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default     = {}
}

variable "logging" {
  description = "Map containing logging configuration."
  type        = map(string)
  default     = {}
}