variable "name" {
  type        = string
  description = "Glue job name"
}

variable "description" {
  type        = string
  description = "Glue job description."
}

variable "glue_version" {
  type        = string
  description = "(Optional) The version of Glue to use."
}

variable "command" {
  type = object({
    name            = optional(string, null)
    script_location = optional(string, null)
    python_version  = number
  })
  description = "The command of the job."
}