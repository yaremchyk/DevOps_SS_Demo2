resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = "${aws_iam_role.ecsTaskExecutionRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_ecr_repository" "service" {
  name = "app-repo"
}

data "aws_ecr_image" "service_image" {
    repository_name = "app-repo"
    image_tag       = "latest"
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "demo-2-task" 
  container_definitions    = <<DEFINITION
  [
    {
      "name": "demo-2-task",
      "image": "025389115636.dkr.ecr.eu-north-1.amazonaws.com/app-repo:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.container_port}
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] 
  network_mode             = "awsvpc"    
  memory                   = var.memory       
  cpu                      = var.cpu_units       
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}