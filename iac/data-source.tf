# retrieve the secret value stored in secrets manager and parse it as a json object
data "aws_secretsmanager_secret" "secrets" {
  name = "rentzone-app-dev-secrets"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
  version_stage = "AWSCURRENT" # default but good to be explicit
}
