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
}
