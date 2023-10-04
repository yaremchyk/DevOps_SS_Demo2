module "ecr" {
  source = "./terraform/modules/ecr"
}

module "network" {
  source = "./terraform/modules/network"
}

module "backend" {
  source = "./terraform/modules/backend"
}