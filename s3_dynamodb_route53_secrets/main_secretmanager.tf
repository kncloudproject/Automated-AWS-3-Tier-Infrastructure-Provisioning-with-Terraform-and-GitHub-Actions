# Get current AWS account ID
data "aws_caller_identity" "current" {}

# Get current AWS region
data "aws_region" "current" {}


resource "aws_secretsmanager_secret" "example" {
  name        = "rentzone-app-dev-secrets"
  description = "App Credentials Stored Securely"
}

resource "aws_secretsmanager_secret_version" "secrets" {
  secret_id = aws_secretsmanager_secret.example.id
  secret_string = jsonencode({
    rds_db_name  = local.rds_db_name
    username     = local.db_username
    password     = local.db_password
    ecr_registry = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com"

  })
}
