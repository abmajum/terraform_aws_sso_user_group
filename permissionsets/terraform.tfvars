permission_sets = {
"AWSServiceCatalogAdminFullAccess": {
        "description": "Provides full access to AWS Service Catalog admin capabilities",
        "session_duration": "PT1H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/AWSServiceCatalogAdminFullAccess"
        ]
    },
    "AWSReadOnlyAccess": {
        "description": "This policy grants permissions to view resources and basic metadata across all AWS services",
        "session_duration": "PT1H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
        ]
    },
    "AWSAdministratorAccess": {
        "description": "Provides full access to AWS services and resources",
        "session_duration": "PT1H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/AdministratorAccess",
            "arn:aws:iam::aws:policy/job-function/Billing"
        ]
    },
    "AWSPowerUserAccess": {
        "description": "Provides full access to AWS services and resources, but does not allow management of Users and groups",
        "session_duration": "PT4H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/IAMFullAccess",
            "arn:aws:iam::aws:policy/PowerUserAccess"
        ]
    },
    "AWSOrganizationsFullAccess": {
        "description": "Provides full access to AWS Organizations",
        "session_duration": "PT1H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/AWSOrganizationsFullAccess"
        ]
    },
    "Managed_service_dev": {
        "description": null,
        "session_duration": "PT4H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
            "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy",
            "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
            "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
            "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
            "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
            "arn:aws:iam::aws:policy/PowerUserAccess"
        ],
        "inline_policy": "{\"Statement\":[{\"Sid\":\"Statement1\",\"Effect\":\"Allow\",\"Action\":[\"iam:ListRoles\",\"iam:CreateRole\",\"iam:UpdateRole\",\"iam:UpdateRoleDescription\",\"iam:AttachRolePolicy\",\"iam:CreatePolicy\",\"iam:GetRole\",\"iam:PutRolePolicy\",\"iam:PassRole\",\"iam:CreateServiceLinkedRole\",\"iam:GetRolePolicy\",\"iam:ListRolePolicies\",\"iam:AddRoleToInstanceProfile\",\"iam:DeleteRole\",\"iam:GetPolicy\",\"iam:GetPolicyVersion\",\"iam:ListPolicies\",\"iam:ListPolicyTags\",\"iam:ListPolicyVersions\",\"iam:ListRoleTags\",\"iam:TagRole\",\"iam:TagPolicy\",\"iam:UntagPolicy\",\"iam:UntagRole\",\"iam:CreatePolicyVersion\",\"iam:DeletePolicy\",\"iam:DeleteRolePolicy\",\"iam:DeleteServiceLinkedRole\",\"iam:*\"],\"Resource\":[\"*\"]}]}"
    },
    "Control-tower-ro": {
        "description": null,
        "session_duration": "PT4H",
        "managed_policies": []
    },
    "AdministratorAccess": {
        "description": null,
        "session_duration": "PT1H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/AdministratorAccess",
            "arn:aws:iam::aws:policy/job-function/Billing"
        ]
    },
    "Billing": {
        "description": null,
        "session_duration": "PT1H",
        "managed_policies": [
            "arn:aws:iam::aws:policy/job-function/Billing"
        ]
    }
}

# account_assignments = [
# {
#     principal_name = "ninad@infracloud.io"
#     principal_type = "USER"
#     permission_set = "AdministratorAccess"
#     account_ids    = [393188027970,527360621799,798799997]
# },
# {
#     principal_name = "ninad@infracloud.io"
#     principal_type = "USER"
#     permission_set = "AWSPowerUserAccess"
#     account_ids    = [527360621799]
# }
# ]
