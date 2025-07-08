module "component" {
    for_each = var.components
    source = "https://github.com/kkumar-2655/terraform-aws-roboshop.git?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority
}