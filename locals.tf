locals {
 server_names = [
   for i in range(var.replicas) : format("memcached-%d.%s.%s.svc.cluster.local:11211", i, kubernetes_service.memcached.metadata.0.name, var.namespace)
 ]

}
