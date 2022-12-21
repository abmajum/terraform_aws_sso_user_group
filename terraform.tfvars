#users = ["dhruv.mewada@infracloud.io", "abhishek.majumdar@infracloud.io"]

users = {
  "abhishek.majumdar@infracloud.io" = {
    display_name = "Abhishek Majumdar"
    given_name   = "Abhishek"
    family_name  = "Majumdar"
    user_name    = "abhishek.majumdar@infracloud.io"
  }
  "vaibhav.gupta@infracloud.io" = {
    display_name = "Vaibhav Gupta"
    given_name   = "Vaibhav"
    family_name  = "Gupta"
    user_name    = "vaibhav.gupta@infracloud.io"
  }
}
groups = ["Inception", "InfoSec-team"]

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