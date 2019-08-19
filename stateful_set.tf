resource "kubernetes_stateful_set" "memcached" {
  metadata {
    name = "memcached"

    labels = {
      app = "memcached"
    }

    namespace = var.namespace
  }

  spec {
    replicas               = var.replicas
    revision_history_limit = 5

    selector {
      match_labels = {
        app = "memcached"
      }
    }

    service_name = kubernetes_service.memcached.metadata[0].name

    update_strategy {
      type = "RollingUpdate"
    }

    template {
      metadata {
        labels = {
          app = "memcached"
        }
      }

      spec {
        container {
          name              = "memcached"
          image             = "memcached:1.5.12-alpine"
          image_pull_policy = "Always"

          port {
            name           = "memcached"
            container_port = "11211"
          }

          liveness_probe {
            tcp_socket {
              port = "memcahced"
            }

            initial_delay_seconds = 30
            timeout_seconds       = 5
          }

          readiness_probe {
            tcp_socket {
              port = "memcached"
            }

            initial_delay_seconds = 5
            timeout_seconds       = 1
          }
        }

        container {
          name              = "metrics"
          image             = "quay.io/prometheus/memcached-exporter:v0.4.1"
          image_pull_policy = "Always"

          port {
            name           = "metrics"
            container_port = 9150
          }
        }
      }
    }
  }
}

