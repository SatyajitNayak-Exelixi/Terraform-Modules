# 🌍 Terraform Modules Repository

This repository contains reusable **Terraform modules** to deploy and manage cloud infrastructure in a **modular and consistent** way.
Each module (like VPC, EC2, S3, or RDS) can be reused across different environments — **Dev, QA, and Prod** — using variable files.

---

## 📁 Repo Structure

```
Terraform-Modules/
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── s3/
│   └── rds/
├── env/
│   ├── dev/
│   ├── qa/
│   └── prod/
└── README.md
```

---

## ⚙️ Key Files

| File                 | Description                           |
| -------------------- | ------------------------------------- |
| **main.tf**          | Defines main infrastructure resources |
| **variables.tf**     | Declares input variables              |
| **terraform.tfvars** | Stores environment-specific values    |
| **cred.tf**          | Configures provider and credentials   |

---

## 🚀 Usage

```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```


---
