locals {

  goal = flatten([
    for grp in var.groups : [
      for usr in grp.users : {
        group  = grp.group
        user = usr
      }
    ]
  ])
  managed_groups = {
    for each in local.goal : "${each.user}.${each.group}" => each
  }

 ssoadmin_instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
 managed_ps            = { for ps_name, ps_attrs in var.permission_sets : ps_name => ps_attrs if can(ps_attrs.managed_policies) }
 customer_managed_ps   = { for ps_name, ps_attrs in var.permission_sets : ps_name => ps_attrs if can(ps_attrs.customer_managed_policies) }
 
 # create ps_name and managed policy maps list
 ps_policy_maps = flatten([
    for ps_name, ps_attrs in local.managed_ps : [
      for policy in ps_attrs.managed_policies : {
        ps_name    = ps_name
        policy_arn = policy
      } if can(ps_attrs.managed_policies)
    ]
  ])

 # create ps_name and customer managed policy maps list
 customer_ps_policy_maps = flatten([
    for ps_name, ps_attrs in local.customer_managed_ps : [
      for policy in ps_attrs.customer_managed_policies : {
        ps_name     = ps_name
        policy_name = policy
      } if can(ps_attrs.customer_managed_policies)
    ]
  ])

}
