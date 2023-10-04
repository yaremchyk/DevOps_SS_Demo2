module "ecr" {
  source = "./terraform/modules/ecr"
}

//module "network" {
//  source = "./terraform/modules/network"
//}

module "backend" {
  source = "./terraform/modules/backend"
}

module "ecs_task_definition" {
  source = "./terraform/modules/ecs_task_definition"
}

module "ecs" {
  source = "./terraform/modules/ecs"
  ecs_task_definition=module.ecs_task_definition.ecs_task_definition
}