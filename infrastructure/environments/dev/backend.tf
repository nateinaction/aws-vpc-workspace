terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "worldpeaceio"

    workspaces {
      name = "workspace-dev"
    }
  }
}
