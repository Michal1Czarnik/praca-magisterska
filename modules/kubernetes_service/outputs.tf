output "id" {
  description = "The Kubernetes Managed Cluster ID"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.id
}

output "host" {
  description = "The Kubernetes cluster server host"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0].host
}

output "client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0].client_certificate
}

output "client_key" {
  description = "Base64 encoded private key used by clients to authenticate to the Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0].client_key
}

output "cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.kube_config[0].cluster_ca_certificate
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL that is associated with the cluster"
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.oidc_issuer_url
}

output "agic_mi_id" {
  value = var.settings.ingress_application_gateway != null ? azurerm_kubernetes_cluster.kubernetes_cluster.ingress_application_gateway[0].ingress_application_gateway_identity[0].client_id : "disabled"
  description = "agic id"
}