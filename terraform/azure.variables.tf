variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_location" {}
variable "azure_subscription_id" {}
variable "azure_tenant_id" {}
variable "openshift-public-ip" {
  default = "/subscriptions/7f758ce0-5f13-401a-b1da-973585722bb6/resourceGroups/c2-resources/providers/Microsoft.Network/publicIPAddresses/zgw-public-ip"
}
variable "bastion-public-ip" {
  default = "/subscriptions/7f758ce0-5f13-401a-b1da-973585722bb6/resourceGroups/c2-resources/providers/Microsoft.Network/publicIPAddresses/zgw-public-ip-bastion"
}
