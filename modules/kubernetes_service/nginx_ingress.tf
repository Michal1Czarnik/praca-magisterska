resource "helm_release" "nginx_ingress" {
  count = var.settings.nginx_ingress_enabled ? 1 : 0

  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.10.0"
  namespace        = "nginx-ingress"
  create_namespace = true
  timeout          = 500

  dynamic "set" {
    for_each = local.nginx_ingress_configuration
    content {
      name  = set.key
      value = set.value
    }
  }
}