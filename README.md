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
- For adding Groups edit `terraform/groups.auto.tfvars`
```agsl
groups = [
    {
        "DisplayName": "AWSSecurityAuditors",
        "Description": "Read-only access to all accounts for security audits"
    },
    {
        "DisplayName": "InfoSec-team",
        "Description": null
    }
]
```
- For adding a user in Multiple Groups edit `terraform/user_in_group.auto.tfvars`
```agsl
user_in_group = [
  {
    group   = "Inception"
    users = ["vaibhav.gupta@infracloud.io"]
  },

  {
    group   = "InfoSec-team"
    users = ["vaibhav.gupta@infracloud.io", "abhishek.majumdar@infracloud.io"]
  }
]
```
```ag
