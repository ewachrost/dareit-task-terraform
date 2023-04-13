resource "google_compute_instance" "dareit-vm-ci-sw-1" {
  name         = "dareit-vm-tf-ci-sw-1"
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

  overwrite = true
  
}
resource "google_storage_bucket" "dareit-bucket-ci-sw-1" {
 project       = "potent-bloom-377613"
 name          = "dareit-bucket-tf-ci-sw-1"
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

resource "google_storage_bucket_object" "dareit-bucket-ci-sw-src-1" {
  name   = "index.html"
  source = "public/index.html"
  bucket = google_storage_bucket.dareit-bucket-ci-sw-1.name
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.dareit-bucket-ci-sw-1.id
  role   = "READER"
  entity = "allUsers"

}