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

variable "service_networking" {
  description = "Service networking"
  default     = "servicenetworking.googleapis.com"
}

variable "dns_name" {
  description = "value of the dns name"
  default = "qccchen.me."
}

variable "dns_type" {
  description = "value of the dns type"
  default = "A"
}

variable "dns_ttl" {
  description = "value of the dns ttl"
  default = 300
}

variable "dns_managed_zone" {
  description = "value of the managed zone"
  default = "webapp-zone"
}

variable "serverless_connector_name" {
  description = "The name of the serverless connector"
  default     = "serverless-connector"
}

variable "serverless_connector_ip_cidr_range" {
  description = "The IP CIDR range for the serverless connector"
  default     = "10.8.0.0/28" 
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
  default     = ["8080","443"]
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

variable "firewall_health_checks_source_ranges" {
  description = "Source range for health check"
  default     = ["35.191.0.0/16", "130.211.0.0/22"]
}

# ==================================================
# Webapp instance variables

variable "webapp_instance_name" {
  description = "Name of the webapp instance"
  default     = "webapp-instance"
}

variable "webapp_instance_type" {
  description = "Type of the webapp instance"
  default     = "e2-small"
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
  default     = 50
}

variable "webapp_disk_type" {
  description = "Type of the disk"
  default     = "pd-balanced"
}

variable "service_account_scopes" {
  description = "Scopes for the service account"
  default     = ["cloud-platform"]
}

variable "static_ip_name" {
  description = "Name of the static IP"
  default     = "ipv4-address"
}

variable "iam_logging_admin_role" {
  description = "The role to assign to the service account"
  default     = "roles/logging.admin"
}

variable "iam_monitoring_metric_writer_role" {
  description = "The role to assign to the service account"
  default     = "roles/monitoring.metricWriter"
}

variable "pub_sub_publisher_role" {
  description = "The role to assign to the service account"
  default     = "roles/pubsub.publisher"
}

variable "webapp_service_account" {
  description = "value of the webapp service account"
  default     = "webapp-service-account"
}

variable "webapp_service_account_display_name" {
  description = "The display name for the webapp service account"
  default     = "Webapp Service Account"
}

variable "webapp_template_name" {
  description = "Name of the webapp instance template"
  default     = "webapp-template"
}

variable "webapp_health_check_name" {
  description = "Name of the webapp health check"
  default     = "webapp-health-check"
}

variable "webapp_port" {
  description = "Port of the webapp health check"
  default     = 8080
}

variable "webapp_health_check_path" {
  description = "Path of the webapp health check"
  default     = "/healthz"
}

variable "webapp_manager_name" {
  description = "Name of the instance group manager"
  default     = "webapp-instance-group-manager"
}

variable "webapp_manager_base_instance_name" {
  description = "Base name of the instances"
  default     = "webapp"
}

variable "webapp_autoscaler_name" {
  description = "Name of the autoscaler"
  default     = "webapp-autoscaler"
}

variable "cryptp_key_role" {
  description = "value of the crypto key role"
  default = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
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
  default     = 50
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

variable "db_admin_api" {
  description = "value for the db_admin_api"
  default = "sqladmin.googleapis.com"
}

# ==================================================
# Pub/Sub  variables

variable "sendgrid_api_key" {
  description = "SendGrid API key"
}

variable "pubsub_topic_name" {
  description = "Name of the Pub/Sub topic"
  default     = "verify_email"
}

variable "pubsub_topic_message_retention_duration" {
  description = "Duration to retain messages in the topic"
  default     = "604800s"
}

variable "email_publisher_service_account" {
  description = "The service account to use for email publishing"
  default     = "email-publisher"
}

variable "email_publisher_service_account_display_name" {
  description = "The display name for the email publisher service account"
  default     = "Email Publisher Service Account"
}

variable "cloud_sql_client_role" {
  description = "The role to assign to the service account"
  default     = "roles/cloudsql.client"
}

variable "cloud_functions_bucket_name" {
  description = "Name of the bucket to store the Cloud Functions"
  default     = "cloud-functions-bucket-123123"
}

variable "cloud_functions_bucket_location" {
  description = "Location of the bucket to store the Cloud Functions"
  default     = "us-west2"
}

variable "function_archive_bucket_object_name" {
  description = "Name of the object in the bucket"
  default     = "email-verification-function.zip"
}

variable "function_archive_bucket_source" {
  description = "Path to the source code"
  default     = "../serverless/code.zip"
}

variable "email_verifier_function_name" {
  description = "Name of the Cloud Function"
  default     = "sendVerificationEmailFunction"
}

variable "email_verifier_function_description" {
  description = "Description of the Cloud Function"
  default     = "Sends verification emails to new users"
}

variable "email_verifier_function_runtime" {
  description = "Runtime for the Cloud Function"
  default     = "nodejs18"
}

variable "email_verifier_function_memory" {
  description = "The amount of memory to allocate to the Cloud Function"
  default     = 128
}

variable "email_verifier_function_entry_point" {
  description = "The entry point for the Cloud Function"
  default     = "sendVerificationEmail"
}

variable "email_verifier_function_event_trigger" {
  description = "The event trigger for the Cloud Function"
  default     = "google.pubsub.topic.publish"
}

# ==================================================
# Load balancer  variables

variable "ssl_certificate_name" {
  description = "The name of the SSL certificate"
  default     = "webapp-ssl-cert"
}

variable "https_proxy_name" {
  description = "The name of the HTTPS proxy"
  default     = "webapp-https-proxy"
}

variable "global_forwarding_rule_name" {
  description = "The name of the global forwarding rule"
  default     = "webapp-global-forwarding-rule"
}

variable "url_map_name" {
  description = "The name of the URL map"
  default     = "webapp-url-map"
}

variable "backend_service_name" {
  description = "The name of the backend service"
  default     = "webapp-backend-service"
}

variable "domain_name" {
  description = "The domain name for the managed SSL certificate"
  default     = "qccchen.me"
}

variable "backend_service_protocol" {
  description = "The protocol used by the backend service"
  default     = "HTTP"
}

variable "backend_service_port_name" {
  description = "The port name for the backend service"
  default     = "http"
}

variable "backend_service_timeout_sec" {
  description = "The timeout in seconds for the backend service"
  default     = 10
}

