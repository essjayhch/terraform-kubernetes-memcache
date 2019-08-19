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
      port        = 11211
      target_port = "memcached"
    }

    port {
      name        = "metrics"
      port        = 9150
      target_port = "metrics"
    }

    selector = {
      app = "memcached"
    }
  }
}

