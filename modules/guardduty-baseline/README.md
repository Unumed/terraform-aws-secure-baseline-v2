# guardduty-baseline

Enable GuardDuty in all regions.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.3 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_disable_email_notification"></a> [disable\_email\_notification](#input\_disable\_email\_notification) | Boolean whether an email notification is sent to the accounts. | `bool` | no |
| <a name="input_enable_kubernetes_protection"></a> [enable\_kubernetes\_protection](#input\_enable\_kubernetes\_protection) | Configure and enable Kubernetes audit logs as a data source for Kubernetes protection. Defaults to `true`. | `bool` | no |
| <a name="input_enable_malware_protection"></a> [enable\_malware\_protection](#input\_enable\_malware\_protection) | Configure and enable Malware Protection as data source for EC2 instances with findings for the detector. Defaults to `true`. | `bool` | no |
| <a name="input_filter_config"></a> [filter\_config](#input\_filter\_config) | Specifies AWS GuardDuty Filter configuration.<br/>  `name` - The name of the filter<br/>  `rank` - Specifies the position of the filter in the list of current filters. Also specifies the order in which this filter is applied to the findings.<br/>  `action` - Specifies the action that is to be applied to the findings that match the filter. Can be one of ARCHIVE or NOOP.<br/>  `criterion` - Configuration block for `finding_criteria`. Composed by `field` and one or more of the following operators: `equals` \| `not_equals` \| `greater_than` \| `greater_than_or_equal` \| `less_than` \| `less_than_or_equal`. | <pre>list(object({<br/>    name        = string<br/>    description = optional(string)<br/>    rank        = number<br/>    action      = string<br/>    criterion = list(object({<br/>      field                 = string<br/>      equals                = optional(list(string))<br/>      not_equals            = optional(list(string))<br/>      greater_than          = optional(string)<br/>      greater_than_or_equal = optional(string)<br/>      less_than             = optional(string)<br/>      less_than_or_equal    = optional(string)<br/>    }))<br/>  }))</pre> | no |
| <a name="input_finding_publishing_frequency"></a> [finding\_publishing\_frequency](#input\_finding\_publishing\_frequency) | Specifies the frequency of notifications sent for subsequent finding occurrences. | `string` | no |
| <a name="input_invitation_message"></a> [invitation\_message](#input\_invitation\_message) | Message for invitation. | `string` | no |
| <a name="input_master_account_id"></a> [master\_account\_id](#input\_master\_account\_id) | AWS account ID for master account. | `string` | no |
| <a name="input_member_accounts"></a> [member\_accounts](#input\_member\_accounts) | A list of IDs and emails of AWS accounts which associated as member accounts. | <pre>list(object({<br/>    account_id = string<br/>    email      = string<br/>  }))</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map(string)` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_guardduty_detector"></a> [guardduty\_detector](#output\_guardduty\_detector) | The GuardDuty detector. |
<!-- END_TF_DOCS -->
