# 🚀 Terraform EC2 Instance Setup with Separate Folders per Environment (Dev, QA, Prod)

This guide provides a **clean, modular, and user-friendly** approach to deploy EC2 instances in AWS for Dev, QA, and Prod using **separate folders per environment**, ensuring independent state files.

---

## 📁 Folder Structure

```
Terraform-Modules/
├── modules/
│   └── ec2-instance/
│       ├── main.tf
│       ├── variables.tf
├── dev/
│   └── terraform.tfvars
├── qa/
│   └── terraform.tfvars
└── prod/
    └── terraform.tfvars
```

* **modules/ec2-instance/** → Contains reusable EC2 module (`main.tf`, `variables.tf`)
* **dev/** → Environment-specific folder with `terraform.tfvars` for Dev
* **qa/** → Environment-specific folder with `terraform.tfvars` for QA
* **prod/** → Environment-specific folder with `terraform.tfvars` for Prod

> Each folder maintains its **own Terraform state file** automatically.

---

## 🗂️ EC2 Module Files

### main.tf

```hcl
provider "aws" {
  region = var.region
}

resource "aws_instance" "my_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id

  tags = {
    Name        = var.env_tag
    Environment = var.env_tag
  }
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
```

### variables.tf

```hcl
variable "region" {
  description = "AWS region"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for EC2 access"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "env_tag" {
  description = "Environment tag (dev, qa, prod)"
  type        = string
}
```

---

## 🌱 Environment-Specific terraform.tfvars

### dev/terraform.tfvars

```hcl
region             = "us-east-1"
ami_id             = "ami-0c55b159cbfafe1f0"
instance_type      = "t2.micro"
key_name           = "my-keypair-dev"
security_group_id  = "sg-0dev1234567890"
subnet_id          = "subnet-0dev1234567890"
env_tag            = "dev"
```

### qa/terraform.tfvars

```hcl
region             = "us-east-1"
ami_id             = "ami-0c55b159cbfafe1f0"
instance_type      = "t2.micro"
key_name           = "my-keypair-qa"
security_group_id  = "sg-0qa1234567890"
subnet_id          = "subnet-0qa1234567890"
env_tag            = "qa"
```

### prod/terraform.tfvars

```hcl
region             = "us-east-1"
ami_id             = "ami-0c55b159cbfafe1f0"
instance_type      = "t2.micro"
key_name           = "my-keypair-prod"
security_group_id  = "sg-0prod1234567890"
subnet_id          = "subnet-0prod1234567890"
env_tag            = "prod"
```

---

## 🪜 Steps to Deploy

### 1️⃣ Initialize and Deploy Dev Environment

```bash
cd dev
terraform init ../modules/ec2-instance
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars" -auto-approve
```

### 2️⃣ Initialize and Deploy QA Environment

```bash
cd qa
terraform init ../modules/ec2-instance
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars" -auto-approve
```

### 3️⃣ Initialize and Deploy Prod Environment

```bash
cd prod
terraform init ../modules/ec2-instance
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars" -auto-approve
```

> Each folder now maintains its **own state file (`terraform.tfstate`)** automatically.

---

## 🧹 Destroy Resources per Environment

```bash
# Dev
cd dev
terraform destroy -var-file="terraform.tfvars" -auto-approve

# QA
cd qa
terraform destroy -var-file="terraform.tfvars" -auto-approve

# Prod
cd prod
terraform destroy -var-file="terraform.tfvars" -auto-approve
```

---

✅ **This setup is fully modular, environment-specific, and maintains separate state files per environment.**
