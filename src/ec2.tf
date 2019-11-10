data "aws_ami" "ubuntu" {
  owners      = ["self"]
  most_recent = true

  filter {
    name   = "name"
    values = ["nategay-workspace-aws-ubuntu-18.04*"]
  }
}

data "template_file" "argo_protected_userdata" {
  template = file("${path.module}/files/userdata.template.sh")
  vars = {
    users_public_key_bucket = var.users_public_key_bucket
  }
}

resource "aws_instance" "workspace" {
  count = var.workspace_enabled ? 1 : 0

  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.workspace_instance_type
  iam_instance_profile = aws_iam_instance_profile.workspace_iam_instance_profile.name

  subnet_id                   = aws_subnet.public[count.index].id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_vpc.network.default_security_group_id,
    aws_security_group.workspace.id,
  ]

  ebs_optimized = true
  root_block_device {
    encrypted = true
  }
  user_data = data.template_file.argo_protected_userdata.rendered

  tags = {
    Name = var.project_name
  }
}

