resource "kubernetes_service" "memcached" {
  metadata {
    name      = "memcached"
    namespace = var.namespace

    labels = {
      app = "memcached"
    }
  }

  spec {
    cluster_ip = "None"

    port {
      name        = "memcached"
      port        = var.memcache_port
      target_port = "memcached"
    }

    port {
      name        = "metrics"
      port        = var.metrics_port
      target_port = "metrics"
    }

    selector = {
      "app.kubernetes.io/name" = var.set_name
      "app.kubernetes.io/part-of" = var.set_name
    }
  }
}

