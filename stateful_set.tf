resource "kubernetes_stateful_set" "memcached" {
  wait_for_rollout = false

  metadata {
    name = local.instance_name

    labels = {
      "app.kubernetes.io/name" = local.instance_name
      "app.kubernetes.io/part-of" = "memcached"
    }

    namespace = var.namespace
  }

  spec {
    replicas               = var.replicas
    revision_history_limit = 5

    selector {
      match_labels = {
        "app.kubernetes.io/name" = local.instance_name
        "app.kubernetes.io/part-of" = "memcached"
      }
    }

    service_name = kubernetes_service.memcached.metadata[0].name

    update_strategy {
      type = "RollingUpdate"
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = local.instance_name
          "app.kubernetes.io/part-of" = "memcached"
        }
      }

      spec {
        security_context {
          fs_group = var.fs_group
          run_as_user = var.run_as
          run_as_group = 0
        }
        container {
          name              = "memcached"
          image             = "memcached:1.5.12-alpine"
          image_pull_policy = "Always"

          command = concat([
            "memcached",
            "-m ${var.max_item_memory}",
          ], var.extra_arguments)

          port {
            name           = "memcached"
            container_port = var.memcache_port
          }

          liveness_probe {
            tcp_socket {
              port = "memcached"
            }

            initial_delay_seconds = 30
            timeout_seconds       = 5
          }

          resources {
            requests = {
              memory = local.actual_resource_requests["memory"]
              cpu = local.actual_resource_requests["cpu"]
            }

            limits = {
              memory = local.actual_resource_limits["memory"]
              cpu = local.actual_resource_limits["cpu"]
            }
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
            container_port = var.metrics_port
          }
        }
      }
    }
  }
}

