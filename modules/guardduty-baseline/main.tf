resource "aws_guardduty_detector" "default" {
  enable                       = true
  finding_publishing_frequency = var.finding_publishing_frequency

  # datasources can't be individually managed in each member account.
  dynamic "datasources" {
    for_each = var.master_account_id == "" ? [var.master_account_id] : []

    content {
      s3_logs {
        enable = true
      }
      kubernetes {
        audit_logs {
          enable = var.enable_kubernetes_protection
        }
      }
      malware_protection {
        scan_ec2_instance_with_findings {
          ebs_volumes {
            enable = var.enable_malware_protection
          }
        }
      }
    }
  }

  tags = var.tags
}

resource "aws_guardduty_member" "members" {
  count = length(var.member_accounts)

  detector_id                = aws_guardduty_detector.default.id
  invite                     = true
  account_id                 = var.member_accounts[count.index].account_id
  disable_email_notification = var.disable_email_notification
  email                      = var.member_accounts[count.index].email
  invitation_message         = var.invitation_message
}

resource "aws_guardduty_invite_accepter" "master" {
  count = var.master_account_id != "" ? 1 : 0

  detector_id       = aws_guardduty_detector.default.id
  master_account_id = var.master_account_id
}

##################################################
# GuardDuty Filter
##################################################
resource "aws_guardduty_filter" "this" {
  for_each = var.filter_config != null ? { for filter in var.filter_config : filter.name => filter } : {}

  detector_id = aws_guardduty_detector.default.id

  name        = each.value.name
  action      = each.value.action
  rank        = each.value.rank
  description = each.value.description

  finding_criteria {
    dynamic "criterion" {
      for_each = each.value.criterion
      content {
        field                 = criterion.value.field
        equals                = criterion.value.equals
        not_equals            = criterion.value.not_equals
        greater_than          = criterion.value.greater_than
        greater_than_or_equal = criterion.value.greater_than_or_equal
        less_than             = criterion.value.less_than
        less_than_or_equal    = criterion.value.less_than_or_equal
      }
    }
  }

  tags = var.tags
}
