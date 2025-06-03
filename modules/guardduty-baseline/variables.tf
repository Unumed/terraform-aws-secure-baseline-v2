variable "disable_email_notification" {
  description = "Boolean whether an email notification is sent to the accounts."
  type        = bool
  default     = false
}

variable "finding_publishing_frequency" {
  description = "Specifies the frequency of notifications sent for subsequent finding occurrences."
  type        = string
  default     = "SIX_HOURS"
}

variable "invitation_message" {
  description = "Message for invitation."
  type        = string
  default     = "This is an automatic invitation message from guardduty-baseline module."
}

variable "master_account_id" {
  description = "AWS account ID for master account."
  type        = string
  default     = ""
}

variable "member_accounts" {
  description = "A list of IDs and emails of AWS accounts which associated as member accounts."
  type = list(object({
    account_id = string
    email      = string
  }))
  default = []
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  type        = map(string)
  default = {
    "Terraform" = "true"
  }
}

##################################################
# GuardDuty Filter
##################################################
variable "filter_config" {
  description = <<EOF
  Specifies AWS GuardDuty Filter configuration.
  `name` - The name of the filter
  `rank` - Specifies the position of the filter in the list of current filters. Also specifies the order in which this filter is applied to the findings.
  `action` - Specifies the action that is to be applied to the findings that match the filter. Can be one of ARCHIVE or NOOP.
  `criterion` - Configuration block for `finding_criteria`. Composed by `field` and one or more of the following operators: `equals` | `not_equals` | `greater_than` | `greater_than_or_equal` | `less_than` | `less_than_or_equal`.
  EOF
  type = list(object({
    name        = string
    description = optional(string)
    rank        = number
    action      = string
    criterion = list(object({
      field                 = string
      equals                = optional(list(string))
      not_equals            = optional(list(string))
      greater_than          = optional(string)
      greater_than_or_equal = optional(string)
      less_than             = optional(string)
      less_than_or_equal    = optional(string)
    }))
  }))
  default = null
}

variable "enable_kubernetes_protection" {
  description = "Configure and enable Kubernetes audit logs as a data source for Kubernetes protection. Defaults to `true`."
  type        = bool
  default     = true
}

variable "enable_malware_protection" {
  description = "Configure and enable Malware Protection as data source for EC2 instances with findings for the detector. Defaults to `true`."
  type        = bool
  default     = true
}
