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

variable "source_ranges" {
  description = "Source ranges for the firewall rule"
  default     = ["0.0.0.0/0"]
}

variable "vm_instance_name" {
  description = "Name of the VM instance"
  default     = "my-vm-instance"
}

variable "vm_instance_type" {
  description = "Type of the VM instance"
  default     = "e2-micro"
}

variable "vm_instance_zone" {
  description = "Zone of the VM instance"
  default     = "us-west2-a"
}

variable "custom_image" {
  description = "Custom image for the VM instance"
  default     = "packer-1708684468"
}

variable "disk_size" {
  description = "Size of the disk"
  default     = 100
}

variable "disk_type" {
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