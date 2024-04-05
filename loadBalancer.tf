resource "google_compute_managed_ssl_certificate" "default" {
  name    = var.ssl_certificate_name
  managed {
    domains = [var.domain_name] 
  }
}

resource "google_compute_target_https_proxy" "default" {
  name             = var.https_proxy_name
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = var.global_forwarding_rule_name
  target     = google_compute_target_https_proxy.default.id
  port_range = "443"
}

resource "google_compute_url_map" "default" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_backend_service" "default" {
  name        = var.backend_service_name
  protocol    = var.backend_service_protocol
  port_name   = var.backend_service_port_name
  timeout_sec = var.backend_service_timeout_sec
  
  health_checks = [google_compute_health_check.webapp_health_check.id]
  
  log_config {
    enable = true
  }

  backend {
    group = google_compute_region_instance_group_manager.webapp_manager.instance_group
  }
}

