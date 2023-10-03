resource "aws_ecr_repository" "app_ecr_repo" {
  name = "app-repo"
  force_delete = true
}

resource "aws_ecr_lifecycle_policy" "lanandra_ip_reader" {
  repository = aws_ecr_repository.app_ecr_repo.name