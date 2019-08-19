locals {
 server_names = [
   for i in range(var.replicas) : format("%s-%d.%s.%s.svc.cluster.local:%d", kubernetes_stateful_set.memcached.metadata.0.name, kubernetes_service.memcached.metadata.0.name, var.namespace, var.memcache_port)
 ]

}
