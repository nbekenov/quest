# # cluster
# module "ecs_cluster" {
#   source  = "terraform-aws-modules/ecs/aws"
#   version = "5.0.1"

#   cluster_name = "${local.config["environment"]}-${var.application_name}"

#   cluster_configuration = {
#     execute_command_configuration = {
#       logging = "OVERRIDE"
#       log_configuration = {
#         cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
#       }
#     }
#   }

#   # Capacity provider
#   fargate_capacity_providers = {
#     FARGATE = {
#       default_capacity_provider_strategy = {
#         weight = 50
#         base   = 20
#       }
#     }
#     FARGATE_SPOT = {
#       default_capacity_provider_strategy = {
#         weight = 50
#       }
#     }
#   }

# }


# # TaskDefinition
# # rFargateService


# # ecs execution role - # An IAM Role for the Fargate agent to make AWS API calls on your behalf

# # ecs task role - # An IAM role to control permissions for the containers in your tasks

# # SG "allow egress from everywhere" and "allow connections from ALB"


