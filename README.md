# terraform-aws-alb-ecs
Creates a brand new AWS ECS cluster with an application load balancer infront

This is based off https://github.com/hashicorp/terraform/tree/master/examples/aws-ecs-alb

https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=eu-west-1#LoadBalancers:

## Links to AWS docs

- https://www.terraform.io/docs/providers/aws/r/security_group.html
- https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html
- https://www.terraform.io/docs/providers/aws/r/ecs_service.html
- https://www.terraform.io/docs/providers/aws/r/ecr_repository.html
- https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
- https://www.terraform.io/docs/providers/aws/r/alb.html