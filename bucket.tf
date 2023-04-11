resource "google_storage_bucket" "dareit-bucket-ci-sw" {
 project       = "potent-bloom-377613"
 name          = "dareit-bucket-tf-ci-sw"
 location      = "US"
 storage_class = "STANDARD"

uniform_bucket_level_access = false
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.dareit-bucket-ci-sw.id
  role   = "READER"
  entity = "allUsers"

}