variable "aws_region" {
  type    = string
  default = "sa-east-1"
}

variable "tags" {
  type        = map(string)
  description = ""
  default = {
    automation  = "workinghours=247:expiry=none"
    bpcid       = "BR004"
    business    = "brand=danbrhq:project=ekstest:owner=isaias.souza@dentsu.com:financecontact=rogerio.cavalca@dentsu.com:criticality=low"
    security    = "dataclassification=internal:pii=no"
    technical   = "environment=test"
    project     = "eks_test"
    description = "Managed by Terraform"
  }
}