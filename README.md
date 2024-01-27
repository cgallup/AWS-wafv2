# AWS WAF. # Terraformed all current Managed AWS rules with exclusions. OFAC Custom rule completed. Custom rules APT, and Whitelist-Backend are a WIP #

AWS WAFv2 ACL unit rule count is 1439 of the 1500 total rule capacity, which are listed below.
The below rules are in sequential order by best practices priority. 

**AWS managed rule groups:**
1. AWS-AWSManagedRulesCommonRuleSet             (700 rules)
2. AWS-AWSManagedRulesAmazonIpReputationList    (25 rules)
3. AWS-AWSManagedRulesKnownBadInputsRuleSet     (200 rules)
4. AWS-AWSManagedRulesSQLiRuleSet               (200 rules)
5. AWS-AWSManagedRulesLinuxRuleSet              (200 rules)
6. AWS-AWSManagedRulesAnonymousIpList           (50 rules)
7. AWS-AWSManagedRulesBotControlRuleSet         (50 rules)

**Custom rules:**
1. OFAC, this rule is a country wide block of all countries on the OFAC list which is maintained by compliance.
2. Blocking advanced persistent threats (APT). This rule blocks APT's found  in the SIEM that are maliciously attacking Symbridge web servers.
3. Whitelist-Backend, this rule is the Whitelist is to block non-administrators from the /Backend/ directory.

![Terraform WAF Graph](/graphviz.png "WAF Graph")
