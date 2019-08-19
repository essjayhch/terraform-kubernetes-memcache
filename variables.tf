variable "replicas" {
  description = "Number of pods to provide in stateful set"
  default = 1
}

variable "namespace" {
  description = "Namespace to place this in (needs to exist)"
  default = "default"
}

variable "memcache_port" {
  description = "Port to listen for memcache requests"
  default = 11211
}

variable "metrics_port" {
  description = "Port to listen for memcache metrics"
  default = 9150
}

variable "memory_requests" {
  description = "Memory Resource Requests"
  default = "64Mi"
}

variable "max_item_memory" {
  description = "Ammount of memory reserved for memcached (in megabytes)"
  default = "64"
}
variable "cpu_requests" {
  description = "CPU Resource Requests"
  default = "50m"
}

variable "run_as" {
  description = "uid to run as"
  default = 1001
}

variable "fs_group" {
  description = "FS Group for Securtiy Context"
  default = 1001
}

variable "extra_arguments" {
  description = "Any Extra Arguments"
  type = list(string)
  default = []
}

variable "set_name" {
  description = "Name for kubernetes objects"
  default = "memcached"
}
