# kubernetes_in_cloud
Terraform code for deploying Kubernetes as managed service in AWS &amp; Azure.

Repository contains code that deploys a nginx application with a simple message on EKS / AKS cluster. 
In front of cluster there is ALB / AGW to direct the public traffic inside the cluster.
AWS and Azure modules use common submodules: app and ingress. 
They standardize deployment across different kubernetes platform.
