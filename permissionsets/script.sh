#!/bin/bash

#Script to import data of sso permision lists

declare -a StringArray=$(aws sso-admin list-permission-sets --instance-arn arn:aws:sso:::instance/ssoins-6595b36b2cbf3a38 --output text | awk '{ print $2; }')
permissionset="aws sso-admin describe-permission-set --output json --instance-arn arn:aws:sso:::instance/ssoins-6595b36b2cbf3a38 --permission-set-arn"
managedpolicy="aws sso-admin list-managed-policies-in-permission-set --output json --instance-arn arn:aws:sso:::instance/ssoins-6595b36b2cbf3a38 --permission-set-arn"
# Read the array values with space
for val in ${StringArray[*]}; do
#  ${permissionset} ${val}
 echo "$(${permissionset} ${val} | jq -r ".PermissionSet.Name") = {
    description      = \"$(${permissionset} ${val} | jq -r ".PermissionSet.Description")\",
    session_duration = \"$(${permissionset} ${val} | jq -r ".PermissionSet.SessionDuration")\",
    managed_policies = [$(${managedpolicy} ${val} | jq -r ".AttachedManagedPolicies[].Arn" | sed 's/^/"/;s/$/",/;$s/,$//')]
},"
done

for val in ${StringArray[*]}; do
  echo "terraform import 'aws_ssoadmin_permission_set.this[\"$(${permissionset} ${val} | jq -r ".PermissionSet.Name")\"]' ${val},arn:aws:sso:::instance/ssoins-6595b36b2cbf3a38"
done

for val in ${StringArray[*]}; do
  for val2 in $(${managedpolicy} ${val} | jq -r ".AttachedManagedPolicies[].Arn"); do
   echo "terraform import 'aws_ssoadmin_managed_policy_attachment.this[$(${permissionset} ${val} | jq -r ".PermissionSet.Name").${val2}]' ${val2},${val},arn:aws:sso:::instance/ssoins-6595b36b2cbf3a38"
   done
done