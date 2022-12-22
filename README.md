# Managing Identity Store Users and Groups with Terraform
Perform all the actions in the ```terraform``` directory.<br>
To add users,groups and adding users in groups do changes in ```terraform.tfvars```
- For adding users
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
- For adding Groups
```agsl
groups = ["Inception", "InfoSec-team"]
```
- For adding a user in Multiple Groups
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
