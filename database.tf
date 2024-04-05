resource "google_sql_database_instance" "db_instance" {
  depends_on = [google_service_networking_connection.private_vpc_connection]
  
  name             = var.db_instance_name
  database_version = var.db_version
  region           = var.region
  project          = var.project_id
  
  settings {
    tier = var.db_tier
    disk_size = var.db_disk_size
    disk_type = var.db_disk_type
    availability_type = var.db_availability_type
    
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }

    ip_configuration {
        ipv4_enabled    = false
        private_network = google_compute_network.my_vpc.id
    }    
  }

  deletion_protection = false
}

resource "google_sql_database" "webapp_db" {
  name     = var.db_name
  instance = google_sql_database_instance.db_instance.name
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "[]{}<>:?"
}

resource "google_sql_user" "webapp_db_user" {
  name     = var.db_username
  instance = google_sql_database_instance.db_instance.name
  password = random_password.password.result
}

data "template_file" "startup_script" {
  template = file("./startup_script.sh")

  vars = {
    db_database = "${google_sql_database.webapp_db.name}"
    db_user     = "${google_sql_user.webapp_db_user.name}"
    db_password = "${google_sql_user.webapp_db_user.password}"
    db_host     = "${google_sql_database_instance.db_instance.private_ip_address}"
  }
}

