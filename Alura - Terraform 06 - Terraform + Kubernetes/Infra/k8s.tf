resource "kubernetes_deployment" "deploy_01" {
  metadata {
    name = "django-api"
    labels = {
      name = "django"
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        name = "django"
      }
    }

    template {
      metadata {
        labels = {
          name = "django"
        }
      }

      spec {
        container {
          name = "django"
          image = "999898949736.dkr.ecr.region.amazonaws.com/Terraform-Alura-ECR-Producao:v1"
          resources {
            limits = {
              cpu = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu = "250m"
              memory = "50Mi"
            }
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 8000
            }
            initial_delay_seconds = 30
            period_seconds = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "load_balancer" {
  metadata {
    name = "loadbalancer-django"
  }
  spec {
    selector = {
       name = "django"
    }

    # session_affinity = "ClientIP"

    port {
      port = 80
      target_port = 8000
    }
    type = "LoadBalancer"
  }
}

data "kubernetes_service" "loadbalancer_ip" {
  metadata {
    name = "loadbalancer-django"
  }
}

output "URL-Load-Balancer" {
  value = data.kubernetes_service.loadbalancer_ip.status
}