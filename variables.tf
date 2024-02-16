variable "project_id" {
  description = "Google Cloud project ID"
}

variable "region" {
  description = "GCP region"
  default     = "us-west2"
}

variable "credentials_file" {
  description = "Path to the service account key JSON file"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "my-vpc"
}

variable "webapp_subnet_cidr" {
  description = "CIDR range for the webapp subnet"
  default     = "10.0.1.0/24"
}

variable "db_subnet_cidr" {
  description = "CIDR range for the db subnet"
  default     = "10.0.2.0/24"
}
