output "kubernetes_namespace" {
  description = "Terraform-managed Kubernetes namespace"
  value       = kubernetes_namespace_v1.terraform_managed.metadata[0].name
}
