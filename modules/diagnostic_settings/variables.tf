variable "target_resource_id" {
  description = "The ID of an existing Resource on which to configure Diagnostic Settings"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of a Log Analytics Workspace where Diagnostics Data should be sent"
  type        = string
}