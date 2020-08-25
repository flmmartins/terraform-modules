data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.terraform_state
    key = "${var.environment}/vpc/terraform.tfstate"
    region = var.aws_region
  }
}

data "terraform_remote_state" "kops_state" {
  backend = "s3"
  config = {
    bucket = var.terraform_state
    key = "${var.environment}/kops_state/terraform.tfstate"
    region = var.aws_region
  }
}

data "aws_subnet" "private_subnet" {
  cidr_block = var.private_subnet_cidr
}

data "aws_subnet" "public_subnet" {
  cidr_block = var.public_subnet_cidr
}

data "template_file" "cluster" {
  template                 = file("${path.module}/cluster.yaml.tpl")
  vars                     = {
    cluster_name           = var.cluster_name
    environment            = var.environment
    cluster_state_name     = data.terraform_remote_state.kops_state.outputs.kops_state_bucket["id"]
    cluster_api_allowed_ip = jsonencode(var.cluster_api_allowed_ip)
    cluster_ssh_allowed_ip = jsonencode(var.cluster_ssh_allowed_ip)
    region                 = var.aws_region
    vpc_cidr               = data.terraform_remote_state.vpc.outputs.vpc["cidr"]
    vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc["id"]
    private_subnet_cidr    = var.private_subnet_cidr
    private_subnet_id      = data.aws_subnet.private_subnet.id
    public_subnet_cidr     = var.public_subnet_cidr
    public_subnet_id       = data.aws_subnet.public_subnet.id
    non_masquerade_cidr    = var.kubernetes_cidr
    dns_type               = var.dns_type
    dns_zone               = var.cluster_name
    nodes_type             = var.nodes["instance_type"]
    nodes_image            = var.nodes["image"]
    nodes_min_num          = var.nodes["min_count"]
    nodes_max_num          = var.nodes["max_count"]
    masters_type           = var.masters["instance_type"]
    masters_image          = var.masters["image"]
    masters_min_num        = var.masters["min_count"]
    masters_max_num        = var.masters["max_count"]
    kubernetes_version     = var.kubernetes_version
    module_version         = var.module_version
  }
}

resource "null_resource" "cluster-upload" {
  triggers = {
    file = data.template_file.cluster.rendered
  }

  provisioner "local-exec" {
    command = "kops -v 10 --state=s3://${data.terraform_remote_state.kops_state.outputs.kops_state_bucket.id} replace --force -f -<<EOF\n${data.template_file.cluster.rendered}\nEOF"
  }
}

resource "null_resource" "cluster-secret" {
  depends_on = [null_resource.cluster-upload]
  triggers = {
    file = data.template_file.cluster.rendered
  }
  provisioner "local-exec" {
    command = "kops create secret --name=${var.cluster_name} --state=s3://${data.terraform_remote_state.kops_state.outputs.kops_state_bucket.id} sshpublickey admin -i ${var.pub_admin_key_path}"
  }
}

#This will apply the config from the state
resource "null_resource" "cluster-update" {
  depends_on = [null_resource.cluster-upload,null_resource.cluster-secret]
  triggers = {
    file = data.template_file.cluster.rendered
  }

  provisioner "local-exec" {
    command = "kops -v 10 update cluster --name=${var.cluster_name} --state=s3://${data.terraform_remote_state.kops_state.outputs.kops_state_bucket["id"]} --yes && kops rolling-update cluster --yes --master-interval=5m --node-interval=5m && sleep 60"
  }
}
