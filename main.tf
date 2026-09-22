resource "kind_cluster" "this" {
  name           = var.cluster_name
  wait_for_ready = true

  kind_config {
    kubeadm_config_patches = [
      <<-EOT
        apiVersion: kubelet.config.k8s.io/v1beta1
        kind: KubeletConfiguration
        serverTLSBootstrap: true
      EOT
    ]
  }
}

module "flux_operator_bootstrap" {
  source  = "controlplaneio-fluxcd/flux-operator-bootstrap/kubernetes"
  version = "0.8.0"

  revision = var.bootstrap_revision

  gitops_resources = {
    instance_yaml = file("${path.root}/flux-instance.yaml")
  }

  managed_resources = {
    secrets_yaml = join("---\n", [
      yamlencode({
        apiVersion  = "v1"
        kind        = "Secret"
        metadata    = { name = "sops-age", namespace = "flux-system" }
        type        = "Opaque"
        stringData  = { "age.agekey" = var.age_private_key }
      }),
      yamlencode({
        apiVersion = "v1"
        kind       = "Secret"
        metadata   = { name = "flux-gitops", namespace = "flux-system" }
        type       = "Opaque"
        stringData = {
          githubAppID             = var.github_app_id
          githubAppInstallationID = var.github_app_installation_id
          githubAppPrivateKey     = var.github_app_private_key
        }
      }),
    ])
  }
}
