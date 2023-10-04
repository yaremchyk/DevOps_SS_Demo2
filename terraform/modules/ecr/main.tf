resource "aws_ecr_repository" "app_ecr_repo" {
  name        = "app-repo"
  force_delete = true

  tags = {
    Name = "${var.namespace}_ECRRepo_${var.environment}"
  }
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr-policy"
  description = "ECR policy to allow access from specific VPC/subnet"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:CreateRepository",
          "ecr:CompleteLayerUpload",
          "ecr:UploadLayerPart",
        ],
        Effect = "Allow",
        Resource = aws_ecr_repository.app_ecr_repo.arn,
        Condition = {
          StringEquals = {
            "aws:sourceVpc": "vpc-xxxxxxxxxxxx"  # Specify your VPC ID here
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "ecr_role" {
  name = "ecr-role"
}

resource "aws_iam_policy_attachment" "ecr_attachment" {
  policy_arn = aws_iam_policy.ecr_policy.arn
  roles      = [aws_iam_role.ecr_role.name]
}

resource "aws_ecr_repository_policy" "app_ecr_policy" {
  repository = aws_ecr_repository.app_ecr_repo.name
  policy     = aws_iam_policy.ecr_policy.policy
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