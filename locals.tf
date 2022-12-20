locals {

  goal = flatten([
    for usr in var.user_in_group : [
      for grp in usr.groups : {
        user  = usr.user
        group = grp
      }
    ]
  ])
  managed_groups = {
    for each in local.goal : "${each.user}.${each.group}" => each
  }
}