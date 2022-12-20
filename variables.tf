variable "groups" {
}

variable "users" {
}


variable "user_in_group" {
  type = list(object({
    user   = string
    groups = list(string)
  }))
}