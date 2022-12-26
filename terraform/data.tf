data "aws_ssoadmin_instances" "example" {}

#data "aws_identitystore_user" "id_user" {
#  for_each          = {for u in var.users:  u.UserName => u}
#  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
#
#  alternate_identifier {
#    unique_attribute {
#      attribute_path  = "UserName"
#      attribute_value = each.value.UserName
#    }
#  }
#}
#

#data "aws_identitystore_group" "id_group" {
#  for_each          = toset(var.groups)
#  identity_store_id = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
#
#  filter {
#    attribute_path  = "DisplayName"
#    attribute_value = each.key
#  }
#}
#output "user_id" {
#  value = data.aws_identitystore_user.example[each.value].user_id
#}
#output "arn" {
#  value = tolist(data.aws_ssoadmin_instances.example.arns)[0]
#}
#
#output "identity_store_id" {
#  value = tolist(data.aws_ssoadmin_instances.example.identity_store_ids)[0]
#}
