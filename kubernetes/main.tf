provider "kubernetes" {
  host                   = var.az_aks_host
  username               = var.az_aks_username
  password               = var.az_aks_password
  client_certificate     = base64decode(var.az_aks_client_certificate)
  client_key             = base64decode(var.az_aks_client_key)
  cluster_ca_certificate = base64decode(var.az_aks_cluster_ca_certificate)
}
resource "kubernetes_namespace" "aks1_ns1" {
  metadata {
    name = "prod"
  }
}
resource "kubernetes_deployment" "nginx" {
  metadata {
    namespace = kubernetes_namespace.aks1_ns1.metadata[0].name
    name      = "nginx"
    labels = {
      app = "nginx"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "nginx"
      }
    }
    template {
      metadata {
        labels = {
          App = "nginx"
        }
      }
      spec {
        volume {
          name = "myvolume"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.pvc1.metadata[0].name
          }
        }
        container {
          image = "nginx"
          name  = "nginx"
          volume_mount {
            mount_path = "/usr/share/nginx/html"
            name       = "myvolume"
            read_only  = "false"
          }
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginxsvc"
    namespace = kubernetes_namespace.aks1_ns1.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.nginx.spec.0.template.0.metadata[0].labels.App
    }
    port {
      name        = "80-80"
      protocol    = "TCP"
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_secret" "sec1" {
  metadata {
    name      = "sec1"
    namespace = kubernetes_namespace.aks1_ns1.metadata[0].name
  }
  data = {
    azurestorageaccountname = var.az_storage_account_name
    azurestorageaccountkey  = var.az_storage_primary_access_key
  }
}

resource "kubernetes_storage_class" "stor_class1" {
  metadata {
    name   = "storclass1"
    labels = { "addonmanager.kubernetes.io/mode" : "EnsureExists", "kubernetes.io/cluster-service" : "true" }
  }
  storage_provisioner = "kubernetes.io/azure-file"
  reclaim_policy      = "Delete"
  parameters = {
    skuName = "Standard_LRS"
  }
  volume_binding_mode    = "Immediate"
  allow_volume_expansion = "true"
}

resource "kubernetes_persistent_volume" "pv1" {
  metadata {
    name = "pv1"
  }
  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      azure_file {
        secret_name = kubernetes_secret.sec1.metadata[0].name
        share_name  = var.az_storage_fs_name
      }
    }
    storage_class_name = kubernetes_storage_class.stor_class1.metadata[0].name
    mount_options      = ["dir_mode=0777", "file_mode=0777", "uid=1000", "gid=1000", "mfsymlinks", "nobrl"]
  }
}

resource "kubernetes_persistent_volume_claim" "pvc1" {
  metadata {
    name      = "pvc1"
    namespace = kubernetes_namespace.aks1_ns1.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "2Gi"
      }
    }
    volume_name        = kubernetes_persistent_volume.pv1.metadata.0.name
    storage_class_name = kubernetes_storage_class.stor_class1.metadata[0].name
  }
}
