# Chris Gallup CISSP, MS-IAC
# Web Application Firewall AWS WAFv2
# hashicorp/aws v4.12.1
# Terraform v1.1.9 on darwin arm64
# Input variables defined here are consumed by main.tf

/*
*
Variable "region" {
  description 	= "AWS Zone Name."
  type		= string
  default	= "us-east-1"
}

variable "default_tags" {
  description = "A map of tags applied to all resources created through this module."
  type = map
  default = {
    application = "infra"
    managed = "DevOps/terraform/aws-WAF"
  }
}
*/
variable "name" {
  type        = string
  description = "A friendly name of the WebACL."
}

variable "scope" {
  type        = string
  description = "The scope of this Web ACL. Valid options: CLOUDFRONT, REGIONAL."
}

variable "managed_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = string
    excluded_rules  = list(string)
  }))
  description = "List of Managed WAF rules."
  default = [
    {
      name            = "AWSManagedRulesCommonRuleSet",
      priority        = 10
      override_action = "none"
      excluded_rules  = ["CrossSiteScripting_COOKIE", "UserAgent_BadBots_HEADER"]
    },
    {
      name            = "AWSManagedRulesAmazonIpReputationList",
      priority        = 20
      override_action = "none"
      excluded_rules  = ["AWSManagedIPReputationList", "AWSManagedReconnaissanceList"]
    },
    {
      name            = "AWSManagedRulesKnownBadInputsRuleSet",
      priority        = 30
      override_action = "none"
      excluded_rules  = []
    },
    {
      name            = "AWSManagedRulesSQLiRuleSet",
      priority        = 40
      override_action = "none"
      excluded_rules  = ["SQLi_COOKIE"]
    },
    {
      name            = "AWSManagedRulesLinuxRuleSet",
      priority        = 50
      override_action = "none"
      excluded_rules  = ["LFI_URIPATH"]
    },
    {
      name            = "AWSManagedRulesAnonymousIpList",
      priority        = 60
      override_action = "none"
      excluded_rules  = []
    },
    {
      name            = "AWSManagedRulesBotControlRuleSet",
      priority        = 70
      override_action = "none"
      excluded_rules  = ["CategoryHttpLibrary", "CategorySocialMedia", "SignalNonBrowserUserAgent"]
    }
  ]
}

variable "ip_sets_rule" {
  type = list(object({
    name       = string
    priority   = number
    ip_set_arn = string
    action     = string
  }))
  description = "A rule to detect web requests coming from particular IP addresses or address ranges."
  default     = []
}

variable "ip_rate_based_rule" {
  type = object({
    name     = string
    priority = number
    limit    = number
    action   = string
  })
  description = "A rate-based rule tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span"
  default     = null
}

variable "ip_rate_url_based_rules" {
  type = list(object({
    name                  = string
    priority              = number
    limit                 = number
    action                = string
    search_string         = string
    positional_constraint = string
  }))
  description = "A rate and url based rules tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span"
  default     = []
}

variable "filtered_header_rule" {
  type = object({
    header_types = list(string)
    priority     = number
    header_value = string
    action       = string
  })
  description = "HTTP header to filter . Currently supports a single header type and multiple header values."
  default = {
    header_types = []
    priority     = 1
    header_value = ""
    action       = "block"
  }
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the WAFv2 ACL."
  default     = {}
}

variable "associate_alb" {
  type        = bool
  description = "Whether to associate an ALB with the WAFv2 ACL."
  default     = false
}

variable "alb_arn" {
  type        = string
  description = "ARN of the ALB to be associated with the WAFv2 ACL."
  default     = ""
}

variable "group_rules" {
  type = list(object({
    name            = string
    arn             = string
    priority        = number
    override_action = string
    excluded_rules  = list(string)
  }))
  description = "List of WAFv2 Rule Groups."
  default     = []
}

variable "default_action" {
  type        = string
  description = "The action to perform if none of the rules contained in the WebACL match."
  default     = "allow"
}

variable "OFAC_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = string
    action          = string
    excluded_rules  = list(string)
  }))
  description = "OFAC WAF rules."
  default = [
    {
      name            = "OFAC_rules",
      priority        = 80
      action          = "block"
      override_action = "none"
      excluded_rules  = []
    }
  ]
}
