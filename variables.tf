variable replicas {
  description = "Number of pods to provide in stateful set"
  default = 1
}

variable namespace {
  description = "Namespace to place this in (needs to exist)"
  default = "default"
}

variable memcache_port {
  description = "Port to listen for memcache requests"
  default = 11211
}

variable metrics_port {
  description = "Port to listen for memcache metrics"
  default = 9150
}


variable max_item_memory {
  description = "Ammount of memory reserved for memcached (in megabytes)"
  default = "64"
}

variable run_as {
  description = "uid to run as"
  default = 1001
}

variable fs_group {
  description = "FS Group for Securtiy Context"
  default = 1001
}

variable extra_arguments {
  description = "Any Extra Arguments"
  type = list(string)
  default = []
}

variable instance {
  description = "Name for kubernetes objects"
  default = "default"
}

variable resource_requests {
  type = map

  description = <<EOF
Resource Requests
ref http://kubernetes.io/docs/user-guide/compute-resources/
resource_requests = {
  memory = "64Mi"
  cpu = "50m"
}
EOF
  default = {}
}

variable resource_limits {
  type = map

  description = <<EOF
Resource Requests
ref http://kubernetes.io/docs/user-guide/compute-resources/
resource_limits = {
  memory = "256Mi"
  cpu = "100m"
}
EOF
  default = {}
}

variable gke_neg {
  description =<<EOF
Handle GKE NEG auto annotations.
https://cloud.google.com/kubernetes-engine/docs/how-to/container-native-load-balancing
EOF
  default = false
}
