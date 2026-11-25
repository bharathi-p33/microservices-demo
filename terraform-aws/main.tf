
resource "kubernetes_namespace_v1" "terraform_managed" {
  metadata {
    name = "terraform-managed"

    labels = {
      managed_by = "terraform"
      project    = "online-boutique"
    }
  }
}

locals {
  scenario2_manifests = [
    for manifest in split("---", file("${path.module}/manifests/scenario2/rendered.yaml")) :
    yamldecode(manifest)
    if trimspace(manifest) != ""
  ]
}

resource "kubernetes_manifest" "scenario2" {
  for_each = {
    for manifest in local.scenario2_manifests :
    "${manifest.kind}-${manifest.metadata.name}" => manifest
  }

  manifest = each.value

  depends_on = [
    kubernetes_namespace_v1.terraform_managed
  ]
}

