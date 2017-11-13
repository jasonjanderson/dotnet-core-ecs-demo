### Variables ###
variable "application" {
  default = "dotnet"
}

variable "environment" {
  default = "ecs"
}

variable "role" {
  default = "demo"
}

variable "instance_type" {
  description = "The instance type to use, e.g t2.small"
  default     = "t2.micro"
}

variable "min_size" {
  description = "Minimum instance count"
  default     = 1
}

variable "max_size" {
  description = "Maxmimum instance count"
  default     = 1
}

variable "desired_capacity" {
  description = "Desired instance count"
  default     = 1
}

variable "key_name" {
  description = "SSH key name to use"
  default     = "management-production"
}

variable "instance_ebs_optimized" {
  description = "When set to true the instance will be launched with EBS optimized turned on"
  default     = false
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  default     = 8
}

variable "docker_volume_size" {
  description = "Attached EBS volume size in GB"
  default     = 22
}

variable "image_tag" {
  default = "latest"
}

### Main ###
data "aws_region" "current" {
  current = true
}

data "aws_caller_identity" "current" {}

data "aws_vpc" "current" {
  tags {
    Name = "management"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.current.id}"

  tags {
    Type = "private"
  }
}

module "ecs_cluster" {
  source = "git://github.com/jasonjanderson/ecs-cluster"

  application            = "${var.application}"
  environment            = "${var.environment}"
  role                   = "${var.role}"
  vpc_id                 = "${data.aws_vpc.current.id}"
  subnet_ids             = "${data.aws_subnet_ids.private.ids}"
  instance_type          = "${var.instance_type}"
  min_size               = "${var.min_size}"
  max_size               = "${var.max_size}"
  desired_capacity       = "${var.desired_capacity}"
  key_name               = "${var.key_name}"
  root_volume_size       = "${var.root_volume_size}"
  docker_volume_size     = "${var.docker_volume_size}"
  instance_ebs_optimized = "${var.instance_ebs_optimized}"
}
