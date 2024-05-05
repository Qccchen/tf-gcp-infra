resource "google_compute_network" "my_vpc" {
  name                            = var.vpc_name
  routing_mode                    = var.routing_mode
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "webapp_subnet" {
  name          = var.webapp_subnet_name
  network       = google_compute_network.my_vpc.id
  ip_cidr_range = var.webapp_subnet_cidr
  region        = var.region
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = var.db_subnet_name
  network       = google_compute_network.my_vpc.id
  ip_cidr_range = var.db_subnet_cidr
  region        = var.region
  private_ip_google_access = true
}

resource "google_compute_route" "vpc-route" {
  name             = var.router_name
  dest_range       = var.router_dest_range
  network          = google_compute_network.my_vpc.name
  next_hop_gateway = var.router_next_hop
}

resource "google_compute_firewall" "allow_application_traffic" {
  name    = var.firewall_allow_name
  network = google_compute_network.my_vpc.name

  allow {
    protocol = var.firewall_protocols
    ports    = var.firewall_allow_ports
  }

  target_tags   = [var.firewall_tag]
  source_ranges = var.firewall_health_checks_source_ranges
}

resource "google_compute_firewall" "deny_ssh" {
  name    = var.firewall_deny_name
  network = google_compute_network.my_vpc.name

  allow {
    protocol = var.firewall_protocols
    ports    = var.firewall_deny_ports
  }

  target_tags   = [var.firewall_tag]
  source_ranges = var.firewall_source_ranges
}

resource "google_project_service" "service_networking" {
  service = var.service_networking
  project = var.project_id
}

resource "google_compute_global_address" "private_services_access" {
  project       = var.project_id  
  name          = var.private_services_access_name
  address_type  = var.address_type
  purpose       = var.purpose
  prefix_length = 16
  network       = google_compute_network.my_vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.my_vpc.id
  service                 = var.service_networking
  reserved_peering_ranges = [google_compute_global_address.private_services_access.name]
}

resource "google_dns_record_set" "a" {
  name         = var.dns_name
  type         = var.dns_type
  ttl          = var.dns_ttl
  managed_zone = var.dns_managed_zone
  rrdatas      = [google_compute_global_forwarding_rule.default.ip_address]
}

resource "google_vpc_access_connector" "serverless_connector" {
  name          = var.serverless_connector_name
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.my_vpc.id
  ip_cidr_range = var.serverless_connector_ip_cidr_range
}

resource "random_pet" "key_suffix" {
  length    = 1
}

resource "google_kms_key_ring" "key_ring" {
  name     = "WEBAPP_KEY_RING-${random_pet.key_suffix.id}"
  location = var.region
}

resource "google_kms_crypto_key" "vm_key" {
  name            = "VM_KEY-${random_pet.key_suffix.id}"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = "2592000s" 
}

resource "google_kms_crypto_key" "db_key" {
  name            = "DB_KEY-${random_pet.key_suffix.id}"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = "2592000s"
}

resource "google_kms_crypto_key" "bucket_key" {
  name            = "BUCKET_KEY-${random_pet.key_suffix.id}"
  key_ring        = google_kms_key_ring.key_ring.id
  rotation_period = "2592000s"
}
