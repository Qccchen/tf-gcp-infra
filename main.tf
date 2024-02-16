resource "google_compute_network" "my_vpc" {
  name                            = "my-vpc"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "webapp_subnet" {
  name          = "webapp"
  network       = google_compute_network.my_vpc.id
  ip_cidr_range = var.webapp_subnet_cidr
  region        = var.region
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "db"
  network       = google_compute_network.my_vpc.id
  ip_cidr_range = var.db_subnet_cidr
  region        = var.region
}

resource "google_compute_route" "vpc-route" {
  name             = "vpc-route"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.my_vpc.name
  next_hop_gateway = "default-internet-gateway"
}

