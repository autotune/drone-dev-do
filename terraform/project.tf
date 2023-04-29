resource "digitalocean_project_resources" "wayofthesys" {
  project = data.digitalocean_project.wayofthesys.id
  resources = [
    digitalocean_droplet.drone.urn
  ]
}
