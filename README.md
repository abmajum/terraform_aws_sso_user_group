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
