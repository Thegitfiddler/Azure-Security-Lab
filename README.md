# Azure Security Lab

A production-grade Azure security lab built entirely with Terraform, demonstrating a full security engineering lifecycle across identity, detection, compliance, and DevSecOps.

## Architecture

![Architecture](docs/architecture.png)

## Phases

### Phase 1 — Identity & Zero Trust
- Entra ID users representing real org roles (Security Admin, Developer, SOC Analyst)
- Security groups with least-privilege RBAC scoped to resource group level
- Security Reader and Log Analytics Reader roles assigned to SOC analysts

### Phase 2 — Detection & Response
- Microsoft Sentinel deployed on a Log Analytics Workspace
- Azure Activity and Security log solutions ingesting subscription-wide events
- Three KQL detection rules mapped to MITRE ATT&CK:
  - Brute force login detection (Credential Access)
  - Impossible travel detection (Initial Access)
  - Privilege escalation detection (Privilege Escalation)

### Phase 3 — Compliance & Posture
- Microsoft Defender for Cloud enabled across VMs, Storage, Containers, Key Vaults, and ARM
- Defender alerts routed directly into Sentinel workspace
- CIS Microsoft Azure Foundations Benchmark assigned at subscription level
- NIST SP 800-53 Rev. 5 assigned at subscription level

### Phase 4 — Secure DevSecOps Pipeline
- GitHub Actions pipeline with OIDC authentication (no stored credentials)
- Security gate jobs run in parallel before any deployment:
  - **Gitleaks** — secret scanning across commit history
  - **Checkov** — Terraform IaC security scanning
  - **Trivy** — container image CVE scanning (CRITICAL/HIGH)
- Docker image built and pushed to Azure Container Registry (ACR)
- Deployed to AKS cluster using managed identity (no passwords)
- AKS logs stream into Sentinel workspace

## Tech Stack

| Tool | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| Azure Entra ID | Identity & Access Management |
| Microsoft Sentinel | SIEM & Detection |
| Defender for Cloud | Posture Management |
| Azure Kubernetes Service | Container Orchestration |
| Azure Container Registry | Private Container Registry |
| GitHub Actions | CI/CD Pipeline |
| Gitleaks | Secret Scanning |
| Checkov | IaC Security Scanning |
| Trivy | Container Vulnerability Scanning |
| KQL | Detection Rule Language |

## Security Decisions

- **No stored credentials** — OIDC trust between GitHub and Azure, managed identity between AKS and ACR
- **Least privilege** — every role scoped to minimum required boundary
- **Shift-left security** — all scans run before build, build runs before deploy
- **Centralized logging** — all phases feed one Log Analytics Workspace
- **Multi-framework compliance** — CIS and NIST controls evaluated continuously

## Prerequisites

- Azure subscription
- Terraform >= 1.5.0
- Azure CLI
- Docker
- kubectl

## Usage

```bash
# Clone the repo
git clone https://github.com/Thegitfiddler/Azure-Security-Lab.git
cd Azure-Security-Lab

# Copy and fill in variables
cp terraform.tfvars.example terraform.tfvars

# Initialize Terraform
terraform init

# Deploy
terraform apply
```

## Author

Mike Jones | [GitHub](https://github.com/Thegitfiddler) | Cloud Security Engineer