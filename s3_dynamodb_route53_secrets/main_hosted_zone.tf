# Create Public Hosted Zone
resource "aws_route53_zone" "kn_zone" {
  name = "aws.knsecurecloud.com"
}

# Replace GoDaddy's existing NS records with the Name Server addresses assigned by AWS Route 53