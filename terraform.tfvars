users = ["dhruv.mewada@infracloud.io", "abhishek.majumdar@infracloud.io"]

groups = ["Inception", "InfoSec-team"]

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