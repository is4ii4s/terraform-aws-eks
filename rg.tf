resource "aws_resourcegroups_group" "eks_test" {
  name = "dentsu-${local.name}"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "project",
      "Values": ["eks_test"]
    }
  ]
}
JSON
  }
}