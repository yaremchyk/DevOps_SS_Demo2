resource "aws_ecr_repository" "app_ecr_repo" {
  name        = "app-repo"
  force_delete = true
  vpc_config {
    count = var.az_count
    subnet_ids         = aws_subnet.private[count.index].id  # Attach ECR to public subnets
    security_group_ids = []  # Add security group IDs if needed
  }

  tags = {
    Name = "${var.namespace}_ECRRepo_${var.environment}"
  }
}

resource "aws_ecr_lifecycle_policy" "lanandra_ip_reader" {
  repository = aws_ecr_repository.app_ecr_repo.name


  policy = jsonencode(
  {
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 3
            },
            "action": {
                "type": "expire"
            }
        }
    ]
  })
}