resource kubernetes_service memcached {
  metadata {
    name      = local.instance_name
    namespace = var.namespace

    annotations = var.gke_neg ? {
      "cloud.google.com/neg-status" = ""                             # Eliminates Terraform diff
      "cloud.google.com/neg"        = jsonencode({ ingress = true }) # Eliminates Terraform diff
    } : {}

    labels = {
      "app.kubernetes.io/name"    = local.instance_name
      "app.kubernetes.io/part-of" = "memcached"
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
      "app.kubernetes.io/name"    = local.instance_name
      "app.kubernetes.io/part-of" = "memcached"
    }
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations["cloud.google.com/neg-status"]
    ]
  }
}

