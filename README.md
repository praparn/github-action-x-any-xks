<!--
<div align="center">
  <a href="https://github.com/praparn/github-action-x-any-xks">
    <img src="img/logo.png" alt="Logo" width="600" height="200">
  </a>
-->
<h3 align="left">GitHub Action for Any XKS</h3>
  <p align="left">
     This repository is backgroud to leverage feature of github action and terraform technology for manage in lifecycle of Kubernetes on cloud platform and minimize effort to all contributed for operate Kubernetes cluster (Any XKS). And will continute update
   </p>
</div>

### Slide for Presentation

 * [Slide Presentation](https://speakerdeck.com/praparn/azure-native-meet2022-slide-githubaction)

### Remark

* All credential in this project was designed to store on "secrets" on github. If you new with this. Please kindly following [GitHub Secrets](https://github.com/Azure/actions-workflow-samples/blob/master/assets/create-secrets-for-GitHub-workflows.md)
* As project are coverage multiple cloud provider. So when you fork/clone this repository in action. You can consider to remove unused cloud provider's folder
* In case to create multiple cluster with same cloud provider. Please create new branch for operate , Create new secret of the {XXXX_CLUSTERNAME} and workflow file parameter to fit with your branch


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
* [Video: Setup new repository and Create Azure environment](https://youtu.be/ZMdB07CQ790)
* [Video: Create AKS cluster](https://youtu.be/d3a2iJUyaZo)
* [Video: Modify AKS cluster (Upgrade Version)](https://youtu.be/CSrSdmojmNE)
* [Video: Modify AKS cluster (Change Worker)](https://youtu.be/pcmK0Eh2KNk)
* [Video: Destroy AKS cluster](https://youtu.be/gcsV_6S5Bxk)
* [Video: Destroy Azure environment](https://youtu.be/9IKcZAko690)

*Remark: For use this github action on Azure Portal. Please enable the preview feature 'microsoft.ContainerService/CustomNodeConfigPreview' by follow this KB [Azure Enable Feature](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/preview-features?tabs=azure-portal)

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
* {AZURE_CLIENT_ID}: Input client id (You can check this from "{AZURE_CREDENTIALS}")
  ```sh
  "Azure Client ID"
  ```
* {AZURE_CLIENT_SECRET}: Input client secret id (You can check this from "{AZURE_CREDENTIALS}")
  ```sh
  "Azure Client Secret"
  ```
* {AZURE_SUBSCRIPTION_ID}: Input subscription id (You can check this from "{AZURE_CREDENTIALS}")
  ```sh
  "Azure Subscription ID"
  ```
* {AZURE_TENANT_ID}: Input tanant id (You can check this from "{AZURE_CREDENTIALS}")
  ```sh
  "Azure Tanent ID"
  ```
* {AZURE_REGION}: Input your region on portal. Ex:"eastasia" [Region code](https://azuretracks.com/2021/04/current-azure-region-names-reference/)
  ```sh
  "Region Name"
  ```
* {AZURE_RESOURCEGROUP}: Input your resource group name for create other elements
  ```sh
  "Resource Group Name"
  ```
* {AZURE_STORAGEACCOUNT}: Input your storage account name for keep terraform state on portal. Remark: Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only
  ```sh
  "Storage Account Name"
  ```
* {AZURE_CLUSTERNAME}: Input your AKS cluster name
  ```sh
  "AKS Cluster Name"
  ```
<br><img src="img/aks.jpg" alt="githubaction" width="600" height="600">


### Deployment Step-by-Step

1. Clone the repo
   ```sh
   git clone https://github.com/praparn/github-action-x-any-xks.git
   ```
2. Setup "secrets" elements as explain in Prerequisites
3. Create Azure environment by commit and tag "aks-init-env*"
   ```sh
   git pull
   git tag #check tag duplicate
   echo "aks-init-env-yyyymmddhhmmss" > ./azure-aks/result/result-env-init
   git add -A
   git commit -m "Any commend that you need"
   git tag aks-init-env-yyyymmddhhmmss -m "aks-init-env-yyyymmddhhmmss"
   git push --atomic origin <branch name> aks-init-env-yyyymmddhhmmss
   ```
4. Check progress on tab "action" until it finished. (Optional: Verify result on web console/cli for double check)<br><img src="img/aks1.jpg" alt="githubaction" width="800" height="300">

5. Edit properties of Kubernetes cluster on file "./azure-aks/terraform.tfvars"
   *Remark: 
    - Please check detail for each properties that can configure on file variable.tf
    - Prohibited value start with ###   XXX   ### will be reserve for system
    - Basic configure is avaliable on "#----------Basic System properties" and "#----------Basic AKS properties
    - Advance configure is avaliable on "#----------Advance AKS properties"
6. Create AKS cluster by commit and tag "aks-init-cluster*"
   ```sh
   git pull
   git tag #check tag duplicate
   echo "aks-cluster-create-yyyymmddhhmmss" > ./azure-aks/result/result-aks-init
   git add -A
   git commit -m "Any commend that you need"
   git tag aks-cluster-create-yyyymmddhhmmss -m "aks-cluster-create-yyyymmddhhmmss"
   git push --atomic origin <branch name> aks-cluster-create-yyyymmddhhmmss
   ```
7. Check progress on tab "action" until it finished. (Optional: Verify result on web console/cli for double check)<br><img src="img/aks2.jpg" alt="githubaction" width="800" height="400">
8. Check result of demo application by command:
   ```sh
   git pull
   kubectl get ing -n=management-ui --kubeconfig=./azure-aks/aks-config
   ```
9. Download kubeconfig from file "aks-config" and check application demo on browser <br><img src="img/aks3.jpg" alt="githubaction" width="800" height="500">
   ```sh
   git pull
   kubectl get nodes --kubeconfig=./azure-aks/aks-config
   kubectl get ing -n=management-ui --kubeconfig=./azure-aks/aks-config
   ```

### Modified Kubernetes Configuation

1. Edit properties of Kubernetes cluster on file "./azure-aks/terraform.tfvars"
   *Remark: 
    - Please check detail for each properties that can configure on file variable.tf
    - Prohibited value start with ###   XXX   ### will be reserve for system
    - Basic configure is avaliable on "#----------Basic System properties" and "#----------Basic AKS properties
    - Advance configure is avaliable on "#----------Advance AKS properties"
2. Apply the change on cluster by commit and tag "aks-cluster-modify*"
   ```sh
   git pull
   git tag #check tag duplicate
   echo "aks-cluster-modify-yyyymmddhhmmss" > ./azure-aks/result/result-aks-modify
   git add -A
   git commit -m "Any commend that you need"
   git tag aks-cluster-modify-yyyymmddhhmmss -m "aks-cluster-modify*-yyyymmddhhmmss"
   git push --atomic origin <branch name> aks-cluster-modify-yyyymmddhhmmss
   ```
3. Check progress on tab "action" until it finished. (Optional: Verify result on web console/cli for double check)<br><img src="img/aks4.jpg" alt="githubaction" width="800" height="500">
4. Check modify result <br><img src="img/aks5.jpg" alt="githubaction" width="800" height="500">
5. Use "aks-config" and check modify result via command line
   ```sh
   git pull
   kubectl get nodes --kubeconfig=./azure-aks/aks-config
   ```

### Destroy Step-by-Step
*Remark: When you had been destroy cluster. All properties on "./azure-aks/terraform.tfvars" will roll back to default

1. Delete the cluster by commit and tag "aks-cluster-destroy*"
   ```sh
   git pull
   git tag #check tag duplicate
   echo "aks-cluster-destroy-yyyymmddhhmmss" > ./azure-aks/result/result-aks-destroy
   git add -A
   git commit -m "Any commend that you need"
   git tag aks-cluster-destroy-yyyymmddhhmmss -m "aks-cluster-destroy*-yyyymmddhhmmss"
   git push --atomic origin <branch name> aks-cluster-destroy-yyyymmddhhmmss
   ```
2. Check progress on tab "action" until it finished. (Optional: Verify result on web console/cli for double check)<br><img src="img/aks6.jpg" alt="githubaction" width="800" height="500">
3. Destroy Azure environment by commit and tag "aks-destroy-env*"
   ```sh
   git pull
   git tag #check tag duplicate
   echo "aks-destroy-env-yyyymmddhhmmss" > ./azure-aks/result/result-env-destroy
   git add -A
   git commit -m "Any commend that you need"
   git tag aks-destroy-env-yyyymmddhhmmss -m "aks-destroy-env-yyyymmddhhmmss"
   git push --atomic origin <branch name> aks-destroy-env-yyyymmddhhmmss
   ```
5. Check progress on tab "action" <br><img src="img/aks7.jpg" alt="githubaction" width="800" height="500">

<p align="right">(<a href="#top">back to top</a>)</p>

## AWS EKS Cluster

Cloud provider's folder: azure-aks 

### Prerequisites

Before start to create EKS cluster. Please input credential for operate on ACCESS_KEY and SECRET_KEY

<!-- LICENSE -->
## License

Distributed under the Apacher License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Praparn Lueangphoonlap - [@facebook](https://www.facebook.com/praparn.lungpoonlap) - eva10409@gmail.com

Project Link: [https://github.com/praparn/github-action-x-any-xks](https://github.com/praparn/github-action-x-any-xks)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- Utility Command -->
## Utility Command

1. Git reset and pull everything from remote/main
   ```sh
   git fetch origin
   git reset --hard origin/main
   ```
2. Git reset tag (Delete all tags local/remote)
   ```sh
   git tag -l | xargs git tag -d
   git fetch --tags
   git push origin --delete $(git tag -l) 
   git tag -d $(git tag -l)
   ```
<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo_name/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo_name/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo_name/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo_name/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo_name/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
