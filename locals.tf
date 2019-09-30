variable "default_resource_requests" {
  default = {
    cpu = "50m"
    memory = "64Mi"
  }
  description = "Default Values (Do not set)"
}

variable "default_resource_limits"  {
  default = {
    cpu = null
    memory = null
  }
  description = "Default Values (Do not set)"
}

locals {
 server_names = [
   for i in range(var.replicas) : format("%s-%d.%s.%s.svc.cluster.local:%d", kubernetes_stateful_set.memcached.metadata.0.name, i, kubernetes_service.memcached.metadata.0.name, var.namespace, var.memcache_port)
 ]

 actual_resource_requests = merge(var.default_resource_requests, var.resource_requests)
 actual_resource_limits = merge(var.default_resource_limits, var.resource_limits)

}
