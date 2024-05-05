# tf-gcp-infra

This guide provides instructions on how to use Terraform to set up your infrastructure. Terraform is an open-source tool that allows you to define infrastructure as code using a simple, declarative configuration language.

## Prerequisites

Before you begin, ensure you have the following installed:

- Terraform
- Git
- Access to your cloud provider's CLI and credentials configured (e.g., AWS CLI, Google Cloud SDK)

## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine using Git:

```bash
git clone https://github.com/Qccchen/tf-gcp-infra.git
cd tf-gcp-infra
```

### 2. Initialize Terraform

Initialize Terraform to install the necessary providers:

```bash
terraform init
```

### 3. Create a Terraform Variable File

Create a file named terraform.tfvars to store your variable definitions. This file should not be committed to version control for security reasons.

```hcl
# terraform.tfvars
project_id         = "your-project-id"
region             = "your-region"
webapp_instance_zone = "your-zone"
credentials_file     = "path/to/your/credential"
webapp_custom_image  = "your-custom-image"
domain_name          = "your-domain-name"
sendgrid_api_key     = "your-sendgrid-api-key"
```

### 4. Plan the Infrastructure

Run Terraform plan to preview the changes Terraform will make to your infrastructure:

```bash
terraform plan
```

### 5. Apply the Infrastructure

Apply the changes to set up your infrastructure:

```bash
terraform apply
```

Confirm the action by typing yes when prompted.

## Managing Infrastructure

To change your infrastructure, modify your Terraform configuration files and repeat the plan and apply steps.

To destroy your infrastructure and delete all resources, run:

```bash
terraform destroy
```

Confirm the action by typing `yes` when prompted.

## Note: Setting up Cloud DNS

Please note that setting up Cloud DNS for your domain is not automated in this Terraform configuration. After provisioning your infrastructure, you'll need to set up Cloud DNS manually (include NS, TXT, CNAME) in the Google Cloud Console or through the CLI.

## Contributors

Qian Chen

