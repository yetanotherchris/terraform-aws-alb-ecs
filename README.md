# terraform-aws-alb-ecs
Creates a brand new AWS ECS cluster with an application load balancer infront

This is based off https://github.com/hashicorp/terraform/tree/master/examples/aws-ecs-alb

## Quick start

1. Get an AWS account
2. Create an SSH key (Under EC2->Key Pairs)
3. Install Terraform - `choco install -y terraform` if you use Chocolately on Windows.
4. Clone this repository
5. Rename `terraform.tfvars.example.txt` to `terraform.tfvars`
6. Edit this file to include your AWS credentials, VPC id and two subnets.
  - Alternatively, set the variables using environmental variables with a `TF_VAR_` prefix, e.g. `TF_VAR_ecs_cluster_name`
7. Run `terraform apply` in a Powershell/terminal window in the directory you cloned to.

Once it finishes, wait a couple of minutes for the new instances to appear and then open the `loadbalancer_url` you saw in the terminal window in your browser. You should see a nice big `letmein.io` screen.

Have a look at the load balancer after setup:

https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=eu-west-1#LoadBalancers:

## Included task definition examples

- Letmein (the default), an encrypted notebin service: https://github.com/yetanotherchris/letmein
- Manet, a screenshot service: https://github.com/vbauer/manet
- Ghost blog (from the original example)

## Pushing to the Docker repository in AWS (ECR)

1. Install the awscli, on Windows: `choco install -y awscli`
2. Tag and build your dockerfile, e.g. `docker build -t {docker_repository}/myimage" .
3. Configur AWS: `aws configure`
4. Login to Docker, Powershell version: `iex $(aws ecr get-login).Replace("-e none","")` (AWS put an obselete -e in their command)
5. Push the image: `docker push {docker_repository}/myimage`

Unfortunately there is a bit of a chicken and egg with this terraform script, as you need a repository to push to first before ECR can launch that image. One solution is to put an existing image in the task-definition file as a placeholder, for example ["hello-world"](https://hub.docker.com/_/hello-world/).

## A note about security

The security groups created allow access from everywhere to the load balancer, on port 80, and the EC2 instances, on port 22 - this is the CIDR blocks `0.0.0.0/0` in the variables. You should harden this to add your own IPs. There's a CIDR cheat sheet [here](https://gist.github.com/yetanotherchris/5a48a4f2c7f753450808af2d3524f8fc).

## A similar note, but about permissions

Two IAM roles are created, one for the ECS service, and one for the EC2 instances. Look at `Instance-profile-policy.json` for the EC2 instance, it is given permission to pull from any repository in your account's ECR, and remove container instances from any cluster.

Similarly, the service role is given permissions on any load balancers (in `iam.tf`).

## Instance sizes and 502 gateway problems

The task definition files, which are AWS's version of Docker compose or Kubernetes YML file, dictate how much memory and CPU each container needs. The memory is in megabytes and the CPU is a unit of a single core, much like Kubernetes.

If your EC2 instance doesn't have enough memory for the requirements of all your containers, for example you use t2.micro and your containers need 1024 (1gb) of RAM each, your task won't start and you'll get a 502 Gateway error.

You can see errors on the AWS console in the ECS events: 

`https://eu-west-1.console.aws.amazon.com/ecs/home?region=eu-west-1#/clusters/<YOUR CLUSTER NAME HERE>/services/<YOUR SERVICE NAME HERE>/events`

## Using your own Docker images

You can do this by editing the `task-definition.json` file. Some of the syntax is slightly different from a Docker compose file but should be fairly self-explantory. There is an example of a single Docker image in `task-definition-ghost.json` which came with the original repository from Terraform.

The Terraform `ecs.tf` file will replace one container name and image inside `task-definition.json` with the variables you provide, it doesn't do multiple ones for now.

## What infrastructure does it create?

This diagram misses out the autoscaling group and launch configuration.

```
    +---------+    +-------------------------------------+
    | ELB/ALB |    |  ALB Target Group                   |
    +-+--+----+    | +---------------+  +--------------+ |
      ^  |         | |EC2 Instance   |  | EC2 Instance +---->  +--------+
      |  |         | +---------------+  +--------------+ |     |IAM role|
      |  +---------> +---------------+  +--------------+ |     +--------+
      |            | |EC2 Instance   |  | EC2 Instance | |
      |            | +---------------+  +--------------+ |
      |            +-------------------------------------+     +---------------------------+
      |                                          |             |                           |
+-----+-----------------------------+            |             |Autoscaling Group          |
|  EC2 Container Service (ECS)      |            +-----------> |& Launch configuration     |
|                                   |                          |                           |
|    +-----------------------+      |                          |                           |
|    | ECS (Docker) Registry +----------------------+          |                           |
|    +-----------------------+      |               |          +---------------------------+
|    | Task Definition       |      |               |
|    +-----------------------+      |               |
|    |                       |      |               |
|    | Cluster               |      |               |
|    +-----------------------+      |               ^
|    |  +---------+                 |            +--+------+
|    +-->Ser^ice  +-----------------------------^+IAM role |
|       +---------+                 |            +---------+
|                                   |
+-----------------------------------+
```


## Variables and customisations


## Links to AWS docs

- https://www.terraform.io/docs/providers/aws/r/security_group.html
- https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html
- https://www.terraform.io/docs/providers/aws/r/ecs_service.html
- https://www.terraform.io/docs/providers/aws/r/ecr_repository.html
- https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
- https://www.terraform.io/docs/providers/aws/r/alb.html

- https://www.terraform.io/docs/providers/aws/r/alb_target_group.html
- https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
- https://www.terraform.io/docs/providers/aws/r/autoscaling_attachment.html