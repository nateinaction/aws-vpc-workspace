data "aws_ami" "ubuntu" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_filter_string]
  }
}

data "template_file" "userdata" {
  template = file("${path.module}/files/userdata.template.sh")
  vars = {
    users_public_key_bucket = var.users_public_key_bucket
    workspace_domain = "${var.workspace_subdomain}.${var.workspace_tld}"
    github_access_token = var.github_access_token
  }
}

resource "aws_instance" "workspace" {
  count = var.workspace_enabled ? 1 : 0

  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.workspace_instance_type
  iam_instance_profile = aws_iam_instance_profile.workspace_iam_instance_profile.name

  subnet_id                   = var.workspace_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids = var.workspace_security_group_ids

  root_block_device {
    encrypted = true
  }
  user_data = data.template_file.userdata.rendered

  tags = {
    Name = var.project_name
  }
}

