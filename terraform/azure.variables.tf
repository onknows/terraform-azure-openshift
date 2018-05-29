variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_location" {}
variable "azure_subscription_id" {}
variable "azure_tenant_id" {}
variable "openshift-public-ip" {
  default = "/subscriptions/9e54bcbd-ad57-485e-a4c4-5fb4e661fb9f/resourceGroups/dop-public-ip/providers/Microsoft.Network/publicIPAddresses/dop-public-ip"
}
variable "bastion-public-ip" {
  default = "/subscriptions/9e54bcbd-ad57-485e-a4c4-5fb4e661fb9f/resourceGroups/cloud-shell-storage-westeurope/providers/Microsoft.Network/publicIPAddresses/dop-public-ip-2"
}
