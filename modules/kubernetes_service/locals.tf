locals {
  nginx_ingress_configuration = {
    "controller.replicaCount"                                                                                       = 2
    "controller.nodeSelector.kubernetes\\.io/os"                                                                    = "linux"
    "controller.admissionWebhooks.patch.nodeSelector.kubernetes\\.io/os"                                            = "linux"
    "controller.service.loadBalancerIP"                                                                             = var.settings.nginx_private_ip == null ? "x.x.x.x" : var.settings.nginx_private_ip
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal"                  = true
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path" = "/healthz"
    "controlles.publishService.enabled"                                                                             = true
    "defaultBackend.enabled"                                                                                        = true
    "defaultBackend.nodeSelector.kubernetes\\.io/os"                                                                = "linux"
  }
}
