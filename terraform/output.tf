
output "bastion_public_ip" {
  value = "51.144.183.213" # dynamic ?
}

output "console_public_ip" {
  value = "${azurerm_public_ip.master.ip_address}"
}

output "service_public_ip" {
  value = "${azurerm_public_ip.infra.ip_address}"
}

output "node_count" {
  value = "${var.node_count}"
}

output "master_count" {
  value = "${var.master_count}"
}

output "infra_count" {
  value = "${var.infra_count}"
}

output "admin_user" {
  value = "${var.admin_user}"
}



