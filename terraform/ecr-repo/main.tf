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

### Main ###
resource "aws_ecr_repository" "repo" {
  name = "${var.application}-${var.environment}-${var.role}"
}

### Outputs ###
output "ecr" {
  value = "${aws_ecr_repository.repo.repository_url}"
}
