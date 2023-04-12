
resource "google_compute_instance" "dareit-vm-ci-sw-new" {
  name         = "dareit-vm-tf-ci-sw-new"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["dareit"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        managed_by_terraform = "true"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}
resource "google_storage_bucket" "dareit-bucket-ci-sw-new" {
 project       = "potent-bloom-377613"
 name          = "dareit-bucket-tf-ci-sw-new"
 location      = "US"
 storage_class = "STANDARD"

uniform_bucket_level_access = false

force_destroy = true
  website {
  main_page_suffix = "index.html"
  }
  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
}
}

resource "google_storage_bucket_object" "dareit-bucket-ci-sw-src-new" {
  name   = "index.html"
  source = "public/index.html"
  bucket = google_storage_bucket.dareit-bucket-ci-sw-new.name
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.dareit-bucket-ci-sw-new.id
  role   = "READER"
  entity = "allUsers"

}

resource "google_storage_bucket_object" "picture" {
  name   = "cat.jpg"
  source = "images/cat.jpg"
  bucket = google_storage_bucket.dareit-bucket-ci-sw-new.name
}