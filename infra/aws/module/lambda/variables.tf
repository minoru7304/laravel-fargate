variable "select_flag" {
    type = number
}

variable "function_name" {
    type = string
}

variable "function_role" {
    type = string
}

variable "security_group_ids" {
    type = list(string)
    default = []
}
