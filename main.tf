
resource "aws_identitystore_user" "example" {
  for_each          = var.users
  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]

  #display_name = format("%s %s", title(split(".", split("@", each.value)[0])[0]), title(split(".", split("@", each.value)[0])[1]))
  display_name = each.value["display_name"]
  user_name    = each.value["user_name"]

  name {
    #given_name  = title(split(".", split("@", each.value)[0])[0])
    #family_name = title(split(".", split("@", each.value)[0])[1])
    given_name  = each.value["given_name"]
    family_name = each.value["family_name"]
  }

  emails {
    value   = each.value["user_name"]
    primary = true
    type    = "work"
  }
}
resource "aws_identitystore_group" "this" {
  for_each          = toset(var.groups)
  display_name      = each.value
  description       = each.value
  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
}

resource "aws_identitystore_group_membership" "example" {
  for_each          = local.managed_groups
  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
  group_id          = data.aws_identitystore_group.id_group[each.value.group].id
  member_id         = data.aws_identitystore_user.id_user[each.value.user].id
}
