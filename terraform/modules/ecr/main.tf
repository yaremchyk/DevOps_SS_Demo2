module "network" {
  source = "../network/main.tf"
}

resource "aws_ecr_repository" "app_ecr_repo" {
  name = "app-repo"
  force_delete = true
  vpc_id = aws_vpc.default.id
  subnet_id      = aws_subnet.private[count.index].id
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