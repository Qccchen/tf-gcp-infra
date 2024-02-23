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
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = var.db_subnet_name
  network       = google_compute_network.my_vpc.id
  ip_cidr_range = var.db_subnet_cidr
  region        = var.region
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
  source_ranges = var.source_ranges
}

resource "google_compute_firewall" "deny_ssh" {
  name    = var.firewall_deny_name
  network = google_compute_network.my_vpc.name

  deny {
    protocol = var.firewall_protocols
    ports    = var.firewall_deny_ports
  }

  target_tags   = [var.firewall_tag]
  source_ranges = var.source_ranges
}

resource "google_compute_address" "my_static_ip" {
  name = var.static_ip_name
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_instance_name
  machine_type = var.vm_instance_type
  zone         = var.vm_instance_zone
  
  boot_disk {
    initialize_params {
      image = var.custom_image
      type  = var.disk_type
      size  = var.disk_size
    }
  }

  network_interface {
    network    = google_compute_network.my_vpc.id
    subnetwork = google_compute_subnetwork.webapp_subnet.id
    access_config {
      nat_ip = google_compute_address.my_static_ip.address
    }
  }

  tags = [var.firewall_tag]

  service_account {
    email = var.service_account_email
    scopes = var.service_account_scopes
  }
}
