variable "org" {
  type        = string
  description = "the 3-letter code of the organisation used in the account name"
}

variable "app" {
  type        = string
  description = "The current application name."
}

variable "env" {
  type        = string
  description = "The current environment."
}

variable "product_dir" {
  type        = string
  description = "The root dir of the sfw project"
}

variable "base_dir" {
  type        = string
  description = "The base directory such as /opt or /var or /home/osusr/opt"
}

variable "org_dir" {
  type        = string
  description = "The parent of the product dir"
}


variable "profile" {
  type        = string
  description = "The AWS profile."
}

variable "region" {
  type        = string
  description = "The AWS region."
}

variable "shared_credentials_files" {
  type        = string
  description = "The AWS shared credentials files."
}

variable "shared_config_files" {
  type        = string
  description = "The AWS shared config files."
}

variable "TERRAFORM_VERSION" {
  type        = string
  description = "Version of terraform runtime used to provision this resource"
}

variable "INFRA_VERSION" {
  type        = string
  description = "Version of infra code"
}

variable "CNF_VER" {
  type        = string
  description = "Version of configuration"
}
