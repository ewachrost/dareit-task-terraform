resource "google_storage_bucket" "dareit-bucket-ci-sw" {
 project       = "potent-bloom-377613"
 name          = "dareit-bucket-tf-ci-sw"
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

resource "google_storage_bucket_object" "dareit-bucket-ci-sw-src" {
  name   = "index.html"
  source = "public/index.html"
  bucket = google_storage_bucket.dareit-bucket-ci-sw.name
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.dareit-bucket-ci-sw.id
  role   = "READER"
  entity = "allUsers"

}