// variables.tf

variable "db_username" {
  type = string
}
variable "db_password" {
  type = string
}


# export TF_VAR_db_password=password

# export TF_VAR_db_username=admin