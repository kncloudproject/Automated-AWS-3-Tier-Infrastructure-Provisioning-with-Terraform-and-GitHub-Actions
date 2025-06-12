output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

output "dynamodb_name" {
  value = aws_dynamodb_table.terraform_locks.id
}

output "name_servers" {
  description = "NS records for the aws.knsecurecloud.com hosted zone"
  value       = aws_route53_zone.kn_zone.name_servers
}

output "ecr_registry_uri" {
  value = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com"
}