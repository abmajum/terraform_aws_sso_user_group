# Managing Identity Store resources with Terraform
Perform all the actions in the ```terraform``` directory.<br>
To add users,groups and adding users in groups do changes in corresponding files.
- For adding users edit `terraform/users.auto.tfvars`. 
`users` is a list of lists which have the following keys/value pairs.

| Name | Description | Type | If unset |
|------|-------------|:----:|:-----:|
| UserName | (Required) The email id of the user. | string | Provider default behavior |
| DisplayName | (Required) The name that is typically displayed when the user is referenced. | string | Provider default behavior |
| FamilyName | (optional) last name. | string | Provider default behavior |
| GivenName | (optional) First name. | string | Provider default behavior |
| Primary | ((Optional) When true, this is the primary email associated with the user. | string | Provider default behavior |
| Type | (Optional) The type of email. | string | Provider default behavior |
```agsl
users = [
    {
        "UserName": "vaibhav.gupta@infracloud.io",
        "DisplayName": "Vaibhav Gupta",
        "FamilyName": "Gupta",
        "GivenName": "Vaibhav",
        "Primary": true,
        "Type": "work"
    },
    {
        "UserName": "abhishek.majumdar@infracloud.io",
        "DisplayName": "Abhishek Majumdar",
        "FamilyName": "Majumdar",
        "GivenName": "Abhishek",
        "Primary": true,
        "Type": "work"
    }
]
```
- For adding new Groups or add user in Multiple Groups edit `terraform/user_in_group.auto.tfvars`

`user_in_group` is a list of maps which have the following keys/value pairs.

| Name | Description | Type | If unset |
|------|-------------|:----:|:-----:|
| group | (Required) The name of the Group you want to be present. | string | Provider default behavior |
| description | (Optional) The description of the Group. | string | Provider default behavior |
| users | (Optional) The users needed to be part of the Group. If unset group will be created with zero users | string | Provider default behavior |
```agsl
user_in_group = [
    {
        "group": "AWSControlTowerAdmins",
        "description": "Admin rights to AWS Control Tower core and provisioned accounts",
        "users": [
            "security+main@infracloud.io"
        ]
    },
    {
        "group": "InfoSec-team",
        "description": null,
        "users": [
            "ayesha.saha@infracloud.io",
            "nitesh@infracloud.io",
            "gaurav@infracloud.io",
            "varun.kumar@infracloud.io"
        ]
    }
```
- For adding permission sets edit `terraform/permissionsets.auto.tfvars`. 
`permission_sets` is a map of maps. Key is used as unique value for `for_each` resources. Inner map has the following keys/value pairs.

| Name | Description | Type | If unset |
|------|-------------|:----:|:-----:|
| description | (Optional) The description of the Permission Set. | string | Provider default behavior |
| relay\_state | (Optional) The relay state URL used to redirect users within the application during the federation authentication process | string | Provider default behavior. |
| session\_duration | (Optional) The length of time that the application user sessions are valid in the ISO-8601 standard | string | Provider default behavior. |
| tags | (Optional) Key-value map of resource tags. | string | Provider default behavior |
| managed\_policies | (Optional) List of Managed IAM policies that are attached to permission set. | list(string) | Managed Policies not set. |
| inline\_policy | (Optional) Inline policy that is attached to permission set. | string | Inline policy not set. |

```agsl
permission_sets = {
    "AWSServiceCatalogEndUserAccess": {
        "description": "Provides access to the AWS Service Catalog end user console",
        "session_duration": "PT1H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/AWSServiceCatalogEndUserFullAccess"
        ],
        "inline_policy": "{\"Version\": \"2012-10-17\",\"Statement\": [{\"Sid\": \"AWSControlTowerAccountFactoryAccess\",\"Effect\": \"Allow\",\"Action\": [\"sso:GetProfile\",\"sso:CreateProfile\", \"sso:UpdateProfile\",\"sso:AssociateProfile\",\"sso:CreateApplicationInstance\",\"sso:GetSSOStatus\",\"sso:GetTrust\",\"sso:CreateTrust\",\"sso:UpdateTrust\",\"sso:GetPeregrineStatus\",\"sso:GetApplicationInstance\",\"sso:ListDirectoryAssociations\",\"sso:ListPermissionSets\",\"sso:GetPermissionSet\",\"sso:ProvisionApplicationInstanceForAWSAccount\",\"sso:ProvisionApplicationProfileForAWSAccountInstance\",\"sso:ProvisionSAMLProvider\",\"sso:ListProfileAssociations\",\"sso-directory:ListMembersInGroup\",\"sso-directory:SearchGroups\",\"sso-directory:SearchGroupsWithGroupName\",\"sso-directory:SearchUsers\",\"sso-directory:CreateUser\",\"sso-directory:DescribeGroups\",\"sso-directory:DescribeDirectory\",\"sso-directory:GetUserPoolInfo\",\"controltower:CreateManagedAccount\",\"controltower:DescribeManagedAccount\",\"controltower:DeregisterManagedAccount\",\"s3:GetObject\",\"organizations:describeOrganization\",\"sso:DescribeRegisteredRegions\"],\"Resource\": \"*\"}]}"
    },
    "AWSServiceCatalogAdminFullAccess": {
        "description": "Provides full access to AWS Service Catalog admin capabilities",
        "session_duration": "PT1H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/AWSServiceCatalogAdminFullAccess"
        ]
    }
}
```
