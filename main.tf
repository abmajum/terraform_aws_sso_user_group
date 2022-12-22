
resource "aws_identitystore_user" "example" {
  for_each          = {for u in var.users:  u.UserName => u}
  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
  
  display_name = each.value.DisplayName
  user_name    = each.value.UserName

  name {
    given_name  = each.value.GivenName
    family_name = each.value.FamilyName
  }

  emails {
    value= each.value.UserName
    primary = each.value.Primary
    type = each.value.Type
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
  member_id         = split("/",aws_identitystore_user.example[each.value.user].id)[1]
}
