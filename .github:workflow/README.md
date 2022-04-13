<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<br />
<div align="center">
  <a href="https://github.com/praparn/github-action-x-any-xks">
    <img src="img/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">GitHub Action for Any XKS</h3>

  <p align="center">
     This repository is backgroud to leverage feature of github action and terraform technology for manage in lifecycle of Kubernetes on cloud platform and minimize effort to all contributed for operate Kubernetes cluster (Any XKS). And will continute update

 *Remark: 
   - All credential in this project was designed to store on "secrets" on github. If you new with this. Please kindly following KB on (https://github.com/Azure/actions-workflow-samples/blob/master/assets/create-secrets-for-GitHub-workflows.md)

   - As project are coverage multiple cloud provider. So when you fork/clone this repository in action. You can consider to remove unused cloud provider's folder

   - In case to create multiple cluster with same cloud provider. Just duplicate the cloud provider's folder and modifed workflow of your cloud provider to fit with your cluster properties

    <br />
    <a href="https://github.com/praparn/github-action-x-any-xks"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/praparn/github-action-x-any-xks">View Demo</a>
    ·
    <a href="https://github.com/praparn/github-action-x-any-xks/issues">Report Bug</a>
    ·
    <a href="https://github.com/praparn/github-action-x-any-xks/issues">Request Feature</a>
  </p>
</div>

### Built With

* [Azure Cli](https://docs.microsoft.com/en-us/cli/azure/)
* [AWS Cli](https://aws.amazon.com/th/cli/)
* [Gcloud Cli](https://cloud.google.com/sdk/gcloud)
* [Terraform](https://www.terraform.io/)
* [GitHub Action](https://github.com/features/actions)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Azure AKS Cluster

Cloud provider's folder: aws-eks

### Prerequisites

Before start to create AKS cluster. Please input credential for operate on Azure Portal on github's "secrets" as detail below:
* {AZURE_CREDENTIALS}: Store output in JSON format of your service principle. If you not yet to create service principle. Please follow this KB [Azure Service Principle](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-cli%2Clinux#use-the-azure-login-action-with-a-service-principal-secret)
  ```sh
  {
    "clientId": "<GUID>",
    "clientSecret": "<GUID>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>",
    (...)
  }
  ```
* {AZURE_REGION}: Input your region on portal. Ex:"eastasia" [Region code](https://azuretracks.com/2021/04/current-azure-region-names-reference/)
  ```sh
  "Region Name"
  ```
* {AZURE_RESOURCEGROUP}: Input your resource group name for create other elements
  ```sh
  "Resource Group Name"
  ```
* {AZURE_STORAGEACCOUNT}: Input your storage account name for keep terraform state on portal.
  ```sh
  "Storage Account Name"
  ```

### Installation

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/github_username/repo_name.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

AKS Cluster (Azure Portal)
 Pre-requisition: You