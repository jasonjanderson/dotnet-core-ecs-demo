data "template_file" "task_definition" {
  template = "${file("${path.module}/task_definition.json")}"

  vars {
    region       = "${data.aws_region.current.name}"
    image        = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.application}-${var.environment}-${var.role}:${var.image_tag}"
    region       = "${data.aws_region.current.name}"
    iam_role_arn = "${aws_iam_role.service.arn}"
    log_group    = "${aws_cloudwatch_log_group.log_group.name}"
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                = "${var.application}-${var.environment}-${var.role}"
  container_definitions = "${data.template_file.task_definition.rendered}"

  volume {
    name      = "demo"
    host_path = "/efs/dotnet-demo"
  }
}

resource "aws_ecs_service" "service" {
  name            = "${var.application}-${var.environment}-${var.role}"
  cluster         = "${module.ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.task_definition.arn}"

  desired_count = 1

  placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.application}-${var.environment}-${var.role}"
}
