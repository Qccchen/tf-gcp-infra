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

# ==================================================
# VPC variables

variable "routing_mode" {
  description = "Routing mode for the VPC"
  default     = "REGIONAL"
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

variable "private_services_access_name" {
  description = "The name of the private services access"
  default     = "private-ip-address"
}

variable "address_type" {
  description = "The type of address to reserve"
  default     = "INTERNAL"
}

variable "purpose" {
  description = "The purpose of the address"
  default     = "VPC_PEERING"
}

# ==================================================
# Firewall variables

variable "firewall_allow_name" {
  description = "Name of the firewall rule to allow traffic"
  default     = "allow-application-traffic"
}

variable "firewall_deny_name" {
  description = "Name of the firewall rule to deny traffic"
  default     = "deny-ssh-from-internet"
}

variable "firewall_protocols" {
  description = "Protocols for the firewall rule"
  default     = "tcp"
}

variable "firewall_allow_ports" {
  description = "Ports for the firewall rule"
  default     = ["8080"]
}

variable "firewall_deny_ports" {
  description = "Ports for the firewall rule"
  default     = ["22"]
} 

variable "firewall_tag" {
  description = "Tag for the firewall rule"
  default     = "web-servers"
}

variable "firewall_source_ranges" {
  description = "Source ranges for the firewall rule"
  default     = ["0.0.0.0/0"]
}

# ==================================================
# Webapp instance variables

variable "webapp_instance_name" {
  description = "Name of the webapp instance"
  default     = "webapp-instance"
}

variable "webapp_instance_type" {
  description = "Type of the webapp instance"
  default     = "e2-micro"
}

variable "webapp_instance_zone" {
  description = "Zone of the webapp instance"
  default     = "us-west2-a"
}

variable "webapp_custom_image" {
  description = "Custom image for the webapp instance"
}

variable "webapp_disk_size" {
  description = "Size of the disk"
  default     = 100
}

variable "webapp_disk_type" {
  description = "Type of the disk"
  default     = "pd-balanced"
}

variable "service_account_email" {
  description = "Service account email"
  default     = "packer@tribal-affinity-414200.iam.gserviceaccount.com"
}

variable "service_account_scopes" {
  description = "Scopes for the service account"
  default     = ["cloud-platform"]
}

variable "static_ip_name" {
  description = "Name of the static IP"
  default     = "ipv4-address"
}

# ==================================================
# Database instance variables

variable "db_instance_name" {
  description = "Name of the database instance"
  default     = "db-instance"
}

variable "db_version" {
  description = "Version of the database"
  default     = "MYSQL_8_0"
}

variable "db_tier" {
  description = "Tier of the database"
  default     = "db-f1-micro"
}

variable "db_disk_size" {
  description = "Size of the disk"
  default     = 100
}

variable "db_disk_type" {
  description = "Type of the disk"
  default     = "PD_SSD"
}

variable "db_availability_type" {
  description = "Availability type of the database"
  default     = "REGIONAL"
}

variable "db_name" {
  description = "Name of the database"
  default     = "webapp"
}

variable "db_username" {
  description = "Username for the database"
  default     = "webapp"
}

