variable "groups" {
}

variable "users" {
}

#variable "users" {
#  type = map(object({
#    display_name = string
#    given_name   = string
#    family_name  = string
#    user_name    = string
#  }))
#}

#variable "user_in_group" {
#  type = list(object({
#    group   = string
#    users = list(string)
#  }))
#}
