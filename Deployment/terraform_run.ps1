& cls
& terraform init -backend-config="resource_group_name=<rg-state-file>" -backend-config="storage_account_name=<storage-account-name>" -backend-config="key=terraform.deployment.tfplan"
& terraform workspace select dev || terraform workspace new dev
& terraform validate
& terraform plan -out "terraform.deployment.tfplan"
#& terraform apply terraform.deployment.tfplan