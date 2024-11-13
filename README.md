# IaC
IIKG3005 - Infrastructure as Code

## Overview
This project sets up the infrastructure for an e-commerce platform on Microsoft Azure using Terraform. The infrastructure is deployed across three environments: **Development**, **Staging**, and **Production**.

### Components
- **Virtual Network** with subnets
- **Azure Load Balancer** in front of the web application
- **Azure App Service Plan** and **App Service** for hosting the web application
- **Azure SQL Server** and **SQL Database** for product and user data
- **Azure Storage Account** with a Blob Container for storing product images
- **Remote State Configuration** for managing Terraform state centrally using Azure Blob Storage

## Key Features
- **Environment-specific Configuration**: Separate configurations for dev, staging, and prod environments using Terraform workspaces.
- **Modular Design**: Reusable Terraform modules for networking, app services, database, and storage.
- **Remote State Management**: Uses Azure Blob Storage to store and manage Terraform state files for all environments.
- **CI/CD Ready**: The repository is configured for GitHub Actions (or similar) to automate deployment processes.

## Prerequisites
Before deploying the infrastructure, ensure the following prerequisites are met:
- **Azure Subscription**: Ensure you have an active Azure account.
- **Terraform Installed**: Download Terraform from [terraform.io](https://www.terraform.io/).
- **Azure CLI Installed**: Install the Azure CLI for authentication. [Installation instructions](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
- **Service Principal (Optional)**: Set up an Azure service principal for non-interactive authentication in CI/CD pipelines.

---

## 1. Remote State Configuration

### Step 1: Set Up Remote State Storage
Configure Azure Blob Storage for storing Terraform state files centrally. This step must be performed only once, and the state files will be shared across all environments.

1. **Navigate to the `backend/` directory**:
    ```bash
    cd backend/
    ```
2. **Initialize Terraform**:
    ```bash
    terraform init
    ```
3. **Plan and apply the configuration**:
    ```bash
    terraform apply -var-file="backend.tfvars"
    ```
   This command creates a Storage Account and Blob Container for storing the Terraform state files. The output will include the storage account name, container name, and access key.

---


## 2. Deploying Environment-Specific Infrastructure

After configuring remote state storage, you can deploy the infrastructure for each environment (Development, Staging, Production). Each environment uses its own Terraform workspace and configuration file (`terraform.dev.tfvars`, `terraform.staging.tfvars`, `terraform.prod.tfvars`).

## Step 2: Initialize the Terraform Project
Navigate to the `global/` directory:

```bash
cd ../global/
```

Initialize Terraform to download the required providers and configure the backend for remote state:

```bash
terraform init -backend-config="./env/backend.dev.conf"

or

terraform init -backend-config="./env/backend.prod.conf"
or
terraform init -backend-config="./env/backend.staging.conf"
```



## Step 3: Deploy to Each Environment
You can now plan and apply the infrastructure for each environment.

```bash
terraform plan -var-file="./env/dev.tvars"
terraform apply -var-file="./env/dev.tfvars"

```





Plan and apply the infrastructure for the Staging environment:

```bash
terraform plan -var-file="./env/staging.tfvars"
terraform apply -var-file="./env/staging.tfvars"
```

### Production Environment
For Production, review the plan and approve it before applying:

Plan the infrastructure for Production:

```bash
terraform plan -var-file="./env/prod.tfvars"
```

Once the plan is reviewed and approved, apply the infrastructure:

```bash
terraform apply -var-file="./env/prod.tfvars"
```

## Step 5: View Outputs
After deployment, you can retrieve important outputs like the App Service URL, SQL Server FQDN, and Blob Container URL:

```bash
terraform output
```
