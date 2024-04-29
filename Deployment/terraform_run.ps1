& cls
& terraform init -backend-config="resource_group_name=ess-rg" -backend-config="storage_account_name=vkfileshare" -backend-config="key=terraform.deployment.tfplan"
& terraform workspace select dev || terraform workspace new dev
& terraform validate
& terraform plan -out "terraform.deployment.tfplan"
& terraform apply terraform.deployment.tfplan