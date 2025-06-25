<#
    This script deletes common Terraform files and directories to reset the working directory.
    It removes:
    - .terraform (directory)
    - .terraform.lock.hcl (file)
    - terraform.tfstate (file)
    - terraform.tfstate.backup (file)

    To run this script with execution policy bypass (e.g., in GitHub Actions or local terminal):
    powershell -ExecutionPolicy Bypass -File .\cleanup.ps1
#>

# Delete .terraform directory if it exists
if (Test-Path ".terraform") {
    Remove-Item ".terraform" -Recurse -Force
    Write-Output "Deleted .terraform directory"
} else {
    Write-Output ".terraform directory not found"
}

# Delete .terraform.lock.hcl file if it exists
if (Test-Path ".terraform.lock.hcl") {
    Remove-Item ".terraform.lock.hcl" -Force
    Write-Output "Deleted .terraform.lock.hcl"
} else {
    Write-Output ".terraform.lock.hcl file not found"
}

# Delete terraform.tfstate file if it exists
if (Test-Path "terraform.tfstate") {
    Remove-Item "terraform.tfstate" -Force
    Write-Output "Deleted terraform.tfstate"
} else {
    Write-Output "terraform.tfstate file not found"
}

# Delete terraform.tfstate.backup file if it exists
if (Test-Path "terraform.tfstate.backup") {
    Remove-Item "terraform.tfstate.backup" -Force
    Write-Output "Deleted terraform.tfstate.backup"
} else {
    Write-Output "terraform.tfstate.backup file not found"
}
