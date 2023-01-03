permission_sets = {
  AWSPowerUserAccess = {
    description      = "Provides full access to AWS services and resources, but does not allow management of Users and groups",
    session_duration = "PT4H",
    managed_policies = ["arn:aws:iam::aws:policy/IAMFullAccess", "arn:aws:iam::aws:policy/PowerUserAccess"]
},
  AdministratorAccess = {
    #description      = "Provides full access to AWS services and resources.",
    session_duration = "PT1H",
    managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess", "arn:aws:iam::aws:policy/job-function/Billing"]
},


}
# account_assignments = [
# {
#     principal_name = "ninad@infracloud.io"
#     principal_type = "USER"
#     permission_set = "AdministratorAccess"
#     account_ids    = [393188027970,527360621799,798799997]
# },
# {
#     principal_name = "ninad@infracloud.io"
#     principal_type = "USER"
#     permission_set = "AWSPowerUserAccess"
#     account_ids    = [527360621799]
# }
# ]