# ACI & Terraform demonstration including cloud native services

Plans included in this repository:

Microsoft Azure (az_storage and az_storage_fs)
1. Create Storage Account
2. Tag Storage Account
3. Create File Storage
4. Upload file from root (index.html)

Microsoft Azure AKS (az_aks)
1. Create AKS deployment

AKS/K8s (kubernetes)
1. Create K8s secret for storage
2. Create K8s storage class
3. Create K8s PV
4. Create K8s PVC
5. Create NGINX Deployment
6. Create K8s SVC type LB

----
Todo:

Cisco MultiSite Orchestrator (mso):
1. Create tenant / VRF / CTX (CIDR/SUBNET)
2. Create storage EPG
3. Create AKS EPG
4. Create EXT EPG
5. Create Contracts and filters 
---

Private link configuration automated by cApic

## Getting Started

Enter your Microsoft Azure SP and information in terraform.tfvars. Terraform.tfvars.example can be used as an example. Execute code lke below.
````
terraform init
terraform plan
terraform apply
````

### Prerequisites

1. Microsoft Azure subscription
2. Cloud APIC deployed and initial setup completed (including regions)
3. MSO