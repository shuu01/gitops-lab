output "cluster_name" {
  value = kind_cluster.this.name
}

output "kubeconfig" {
  value     = kind_cluster.this.kubeconfig
  sensitive = true
}

