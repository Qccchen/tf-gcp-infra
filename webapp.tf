resource "google_service_account" "webapp_service_account" {
  account_id   = var.webapp_service_account
  display_name = var.webapp_service_account_display_name
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

data "google_project" "project" {
}

resource "google_kms_crypto_key_iam_binding" "vm_crypto_key_iam_binding" {
  crypto_key_id = google_kms_crypto_key.vm_key.id
  role          = var.cryptp_key_role

  members = [
    "serviceAccount:service-${data.google_project.project.number}@compute-system.iam.gserviceaccount.com",
    "serviceAccount:${google_service_account.webapp_service_account.email}",
  ]
}

# resource "google_compute_instance" "webapp_instance" {
#   name         = var.webapp_instance_name
#   machine_type = var.webapp_instance_type
#   zone         = var.webapp_instance_zone

#   tags = [var.firewall_tag]

#   boot_disk {
#     initialize_params {
#       image = var.webapp_custom_image
#       type  = var.webapp_disk_type
#       size  = var.webapp_disk_size
#     }
#   }

#   network_interface {
#     network    = google_compute_network.my_vpc.id
#     subnetwork = google_compute_subnetwork.webapp_subnet.id
#     access_config {
#       nat_ip = google_compute_address.my_static_ip.address
#     }
#   }

#   metadata = {
#     startup-script = "${data.template_file.startup_script.rendered}"
#   }

#   service_account {
#     email = google_service_account.webapp_service_account.email
#     scopes = var.service_account_scopes
#   }
# }

resource "google_compute_region_instance_template" "webapp_template" {
  name = var.webapp_template_name
  machine_type = var.webapp_instance_type

  tags = [var.firewall_tag]

  disk {
    source_image = var.webapp_custom_image
    disk_size_gb = var.webapp_disk_size
    disk_type    = var.webapp_disk_type
    disk_encryption_key {
      kms_key_self_link = google_kms_crypto_key.vm_key.id
    }
  }

  network_interface {
    network    = google_compute_network.my_vpc.id
    subnetwork = google_compute_subnetwork.webapp_subnet.id
    access_config {}
  }

  metadata = {
    startup-script = "${data.template_file.startup_script.rendered}"
  }

  service_account {
    email  = google_service_account.webapp_service_account.email
    scopes = var.service_account_scopes
  }
}

resource "google_compute_health_check" "webapp_health_check" {
  name               = var.webapp_health_check_name
  check_interval_sec = 30
  timeout_sec        = 10
  healthy_threshold  = 1
  unhealthy_threshold = 2

  http_health_check {
    port    = var.webapp_port
    request_path = var.webapp_health_check_path
  }
}

resource "google_compute_region_instance_group_manager" "webapp_manager" {
  name               = var.webapp_manager_name
  base_instance_name = var.webapp_manager_base_instance_name
  region             = var.region

  version {
    instance_template = google_compute_region_instance_template.webapp_template.id
  }

  named_port {
    name = var.backend_service_port_name
    port = var.webapp_port
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.webapp_health_check.id
    initial_delay_sec = 300
  }
}

resource "google_compute_region_autoscaler" "webapp_autoscaler" {
  name   = var.webapp_autoscaler_name
  region = var.region
  target = google_compute_region_instance_group_manager.webapp_manager.id

  autoscaling_policy {
    max_replicas    = 10
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.05
    }
  }
}