data "digitalocean_domain" "wayofthesys" {
  name = "wayofthesys.com"
}

# Add an A record to the domain for drone.wayofthesys.com
resource "digitalocean_record" "drone" {
  domain = data.digitalocean_domain.wayofthesys.id
  type   = "A"
  name   = "www"
  value  = digitalocean_droplet.drone.ipv4_address 
}
