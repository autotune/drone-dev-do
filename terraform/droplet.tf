# Create standard mbp ssh pub key 
resource "digitalocean_ssh_key" "mbp" {
  name       = "mbp"
  public_key = file("./id_rsa.pub")
}

# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "drone" {
  image    = "ubuntu-20-04-x64"
  name     = "drone"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.mbp.fingerprint]
  user_data = file("user_data.sh")
}
