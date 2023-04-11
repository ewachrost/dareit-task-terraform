# Reserve an external IP
resource "google_compute_global_address" "website" {
  provider = google
  name     = "static-website"
}

# Get the managed DNS zone
data "google_dns_managed_zone" "gcp_website_dev" {
  provider = google
  name     = "gcp-website-dev"
}

# Add the IP to the DNS
resource "google_dns_record_set" "website" {
  provider     = google
  name         = "website.${data.google_dns_managed_zone.gcp_website_dev.gcp-website-dev}"
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.gcp_website_dev.name
  rrdatas      = [google_compute_global_address.website.address]
}
