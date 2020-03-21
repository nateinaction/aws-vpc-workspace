provider "github" {
  individual = true
}

resource "github_user_ssh_key" "example" {
  title = var.ssh_key_name
  key   = file(var.public_ssh_key_filepath)
}
