resource "google_service_account" "webapp_service_account" {
  account_id   = "webapp-service-account"
  display_name = "Webapp Service Account"
}

resource "google_project_iam_binding" "logging_admin" {
  project = var.project_id
  role    = var.iam_logging_admin_role

  members = [
    "serviceAccount:${google_service_account.webapp_service_account.email}",
  ]
}

resource "google_project_iam_binding" "monitoring_metric_writer" {
  project = var.project_id
  role    = var.iam_monitoring_metric_writer_role

  members = [
    "serviceAccount:${google_service_account.webapp_service_account.email}",
  ]
}

resource "google_project_iam_binding" "pub_sub_publisher" {
  project = var.project_id
  role    = var.pub_sub_publisher_role

  members = [
    "serviceAccount:${google_service_account.webapp_service_account.email}",
  ]
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
    email = google_service_account.webapp_service_account.email
    scopes = var.service_account_scopes
  }
}
