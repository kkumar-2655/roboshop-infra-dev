# File: repos/roboshop-infra-dev/infra/90-components/main.tf
module "component" {
    for_each = var.components
    source = "git::https://github.com/kkumar-2655/terraform-aws-roboshop.git?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority
}