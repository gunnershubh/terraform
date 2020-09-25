# Terraform Templates for VPC module.
VPC module will create VPC with 3 subnets Public, Private and Protected and spans them across AZs, also their route tables, routes, SG, NATs, IGWs.

Route53 Zone will be associated with a VPC, and it will enable VPC flow log.
## Files Layout
```
.
├── README.md
├── backend.tf
├── data.tf
├── iam.tf
├── outs.tf
├── provider.tf
├── route53.tf
├── terraform.tfvars
├── vars.tf
└── vpc.tf
```
