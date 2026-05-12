resource "google_billing_budget" "budget" {

  count = var.enable_budget_alert ? 1 : 0

  billing_account = var.billing_account_id

  display_name = var.budget_name

  budget_filter {
    projects = ["projects/${var.project_number}"]
  }

  amount {

    specified_amount {
      currency_code = "USD"
      units         = var.budget_amount
    }

  }

  threshold_rules {
    threshold_percent = 0.5
  }

  threshold_rules {
    threshold_percent = 0.8
  }

  threshold_rules {
    threshold_percent = 0.9
  }

  threshold_rules {
    threshold_percent = 1.0
  }

  all_updates_rule {

    monitoring_notification_channels = [
      var.notification_channel_id
    ]

    disable_default_iam_recipients = false

  }

}