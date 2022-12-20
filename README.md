# Managing Identity Store Users and Groups with Terraform
---------------------------------------------------------
To add users,groups and adding users in groups do changes in ```terraform.tfvars```
- For adding users
```agsl
users = ["vaibhav.gupta@infracloud.io", "abhishek.majumdar@infracloud.io"]
```
- For adding Groups
```agsl
groups = ["Inception", "InfoSec-team"]
```
- For adding a user in Multiple Groups
```agsl
user_in_group = [
  {
    user   = "dhruv.mewada@infracloud.io"
    groups = ["Inception"]
  },

  {
    user   = "abhishek.majumdar@infracloud.io"
    groups = ["InfoSec-team","Inception"]
  }
]
```
