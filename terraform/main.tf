
resource "aws_identitystore_user" "example" {
  for_each          = {for u in var.users:  u.UserName => u}
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  
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
  for_each          = {for g in var.groups:  g.group => g}
  display_name      = each.value.group
  description       = each.value.description
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

resource "aws_identitystore_group_membership" "example" {
  for_each          = local.managed_groups
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = split("/",aws_identitystore_group.this[each.value.group].id)[1]
  member_id         = split("/",aws_identitystore_user.example[each.value.user].id)[1]
}

resource "aws_ssoadmin_permission_set" "this" {
  for_each = var.permission_sets

  name             = each.key
  description      = lookup(each.value, "description", null)
  instance_arn     = local.ssoadmin_instance_arn
  relay_state      = lookup(each.value, "relay_state", null)
  session_duration = lookup(each.value, "session_duration", null)
  tags             = lookup(each.value, "tags", {})
}

resource "aws_ssoadmin_permission_set_inline_policy" "this" {
  for_each = { for ps_name, ps_attrs in var.permission_sets : ps_name => ps_attrs if can(ps_attrs.inline_policy) }

  inline_policy      = each.value.inline_policy
  instance_arn       = local.ssoadmin_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.key].arn
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = { for ps in local.ps_policy_maps : "${ps.ps_name}.${ps.policy_arn}" => ps }

  instance_arn       = local.ssoadmin_instance_arn
  managed_policy_arn = each.value.policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.ps_name].arn
}

resource "aws_ssoadmin_customer_managed_policy_attachment" "this" {
  for_each = { for ps in local.customer_ps_policy_maps : "${ps.ps_name}.${ps.policy_name}" => ps }

  instance_arn       = local.ssoadmin_instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.ps_name].arn
  customer_managed_policy_reference {
    name = each.value.policy_name
    path = "/"
  }
}

resource "aws_ssoadmin_account_assignment" "example" {
  for_each = { for assignment in var.account_assignments: format("%s.%s.%s",assignment.AccountId,assignment.PermissionSetArn,assignment.PrincipalId) => assignment }

  instance_arn       = local.ssoadmin_instance_arn
  permission_set_arn = each.value.PermissionSetArn

  principal_id   = each.value.PrincipalId
  principal_type = each.value.PrincipalType

  target_id   = each.value.AccountId
  target_type = "AWS_ACCOUNT"
}

