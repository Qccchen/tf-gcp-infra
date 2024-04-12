resource "google_pubsub_topic" "verify_email" {
  name    = var.pubsub_topic_name
  message_retention_duration = var.pubsub_topic_message_retention_duration
}

resource "google_service_account" "email_publisher" {
  account_id   = var.email_publisher_service_account
  display_name = var.email_publisher_service_account_display_name
}

resource "google_pubsub_topic_iam_binding" "pubsub_publisher" {
  topic = google_pubsub_topic.verify_email.name
  role  = var.pub_sub_publisher_role

  members = [
    "serviceAccount:${google_service_account.email_publisher.email}",
  ]
}

resource "google_project_iam_member" "email_publisher_sql_client" {
  project = var.project_id
  role    = var.cloud_sql_client_role
  member  = "serviceAccount:${google_service_account.email_publisher.email}"
}

data "google_storage_project_service_account" "gcs_account" {
}

resource "google_kms_crypto_key_iam_binding" "bucket_crypto_key_iam_binding" {
  crypto_key_id = google_kms_crypto_key.bucket_key.id
  role          = var.cryptp_key_role

  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}

resource "google_storage_bucket" "cloud_functions_bucket" {
  name     = var.cloud_functions_bucket_name
  location = var.cloud_functions_bucket_location

  encryption {
    default_kms_key_name = google_kms_crypto_key.bucket_key.id
  }

  depends_on = [google_kms_crypto_key_iam_binding.bucket_crypto_key_iam_binding]
}

resource "google_storage_bucket_object" "function_archive" {
  name   = var.function_archive_bucket_object_name
  bucket = google_storage_bucket.cloud_functions_bucket.name
  source = var.function_archive_bucket_source
}

resource "google_cloudfunctions_function" "email_verifier" {
  name        = var.email_verifier_function_name
  description = var.email_verifier_function_description
  runtime     = var.email_verifier_function_runtime

  available_memory_mb   = var.email_verifier_function_memory
  source_archive_bucket = google_storage_bucket.cloud_functions_bucket.name
  source_archive_object = google_storage_bucket_object.function_archive.name
  entry_point           = var.email_verifier_function_entry_point

  vpc_connector = google_vpc_access_connector.serverless_connector.name
  event_trigger {
    event_type = var.email_verifier_function_event_trigger
    resource   = google_pubsub_topic.verify_email.name
  }

  environment_variables = {
    SENDGRID_API_KEY   = var.sendgrid_api_key
    DB_DATABASE        = "${google_sql_database.webapp_db.name}"
    DB_USER            = "${google_sql_user.webapp_db_user.name}"
    DB_PASSWORD        = "${google_sql_user.webapp_db_user.password}"
    DB_CONNECTION_NAME = "${google_sql_database_instance.db_instance.connection_name}"
  }

  service_account_email = google_service_account.email_publisher.email
}