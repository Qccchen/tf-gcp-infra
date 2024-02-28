resource "google_compute_address" "my_static_ip" {
  name = var.static_ip_name
}

resource "google_compute_instance" "webapp_instance" {
  name         = var.webapp_instance_name
  machine_type = var.webapp_instance_type
  zone         = var.webapp_instance_zone

  tags = [var.firewall_tag]

  boot_disk {
    initialize_params {
      image = var.webapp_custom_image
      type  = var.webapp_disk_type
      size  = var.webapp_disk_size
    }
  }

  network_interface {
    network    = google_compute_network.my_vpc.id
    subnetwork = google_compute_subnetwork.webapp_subnet.id
    access_config {
      nat_ip = google_compute_address.my_static_ip.address
    }
  }

  metadata = {
    startup-script = "${data.template_file.startup_script.rendered}"
  }

  service_account {
    email = var.service_account_email
    scopes = var.service_account_scopes
  }
}
