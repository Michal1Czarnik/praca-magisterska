resource "azuread_group" "group" {
  for_each = var.ad_groups

  display_name     = each.value
  security_enabled = true
}

resource "azuread_group_member" "ad_group_member" {
  for_each = var.ad_group_members

  group_object_id  = azuread_group.group[each.value.group_name].object_id
  member_object_id = data.azuread_user.user[each.value.user].object_id
}