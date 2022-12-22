locals {

  goal = flatten([
    for grp in var.user_in_group : [
      for usr in grp.users : {
        group  = grp.group
        user = usr
      }
    ]
  ])
  managed_groups = {
    for each in local.goal : "${each.user}.${each.group}" => each
  }
}