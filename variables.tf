variable "project_id" {
  description = "Google Cloud project ID"
}

variable "region" {
  description = "GCP region"
  default     = "us-west2"
}

variable "routing_mode" {
  description = "Routing mode for the VPC"
  default     = "REGIONAL"
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

variable "webapp_subnet_name" {
  description = "Name of the webapp subnet"
  default     = "webapp"
}

variable "db_subnet_name" {
  description = "Name of the db subnet"
  default     = "db"
}

variable "router_name" {
  description = "Name of the Cloud Router"
  default     = "vpc-route"
}

variable "router_dest_range" {
  description = "Destination range for the Cloud Router"
  default     = "0.0.0.0/0"
}

variable "router_next_hop" {
  description = "Next hop for the Cloud Router"
  default     = "default-internet-gateway"
}