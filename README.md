
## Infrastructure Provisioning Guide 
This guide outlines the necessary steps to configure secrets, provision core AWS infrastructure using Terraform, and prepare your environment for further deployment workflows.

### Configure GitHub Secrets

Go to **Settings > Secrets and Variables > Actions** and add the following secrets:


    - `AWS_ACCESS_KEY_ID`  
    - `AWS_SECRET_ACCESS_KEY`
    - `ECR_REGISTRY` (initially blank, will be updated in Step 3)


### Provision AWS Infrastructure

Provision the required AWS resources by running the Terraform code in the `S3_DynamoDB_Route53_Secrets` directory.

```bash
cd S3_DynamoDB_Route53_Secrets
terraform init
terraform apply
```
This will create:
- S3 bucket for Terraform backend
- DynamoDB table for state locking
- Route53 Hosted Zone
- Secrets in AWS Secrets Manager

After Terraform completes, locate the ECR registry URL from the output and update the ECR_REGISTRY secret under:
    ```
    Settings > Secrets and Variables > Actions
    ```
### Update DNS Records
Update the NS (Name Server) records in your GoDaddy DNS panel using the Hosted Zone output provided by Terraform.

###  Configure Terraform Backend
Update your Terraform backend configuration to use the newly created:
- S3 bucket for storing state
- DynamoDB table for state locking

Example backend block:
```
terraform {
  backend "s3" {
    bucket         = "your-s3-bucket-name"
    key            = "terraform.tfstate"
    region         = "your-region"
    dynamodb_table = "your-dynamodb-table"
    encrypt        = true
  }
}
```

### Trigger the GitHub Actions Pipeline
Once all configurations and secrets are updated:

- Push a commit to the main branch (or whichever branch is configured to trigger the workflow):

    ```yaml
    git add .
    git commit -m "Trigger pipeline"
    git push origin main
    ```
- Manually Trigger Workflow (If workflow_dispatch is Enabled)
    ```yaml
    on:
    push:
        branches: [ main ]
    workflow_dispatch:
    ```

