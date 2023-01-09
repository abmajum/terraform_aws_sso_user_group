# Managing Identity Store Users and Groups with Terraform
Perform all the actions in the ```terraform``` directory.<br>
To add users,groups and adding users in groups do changes in corresponding files.
- For adding users edit `terraform/users.auto.tfvars`
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
- For adding permission sets edit `terraform/permissionsets.auto.tfvars`. The inline policy should be in string format.
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
