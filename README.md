# Use Terraform runbooks to create DevTestLab Environments

## Register Repository

Register this repository inside your DevTestLab using the master branch and */environments* as Azure Resource Manager template folder path.

[Add a Git repository to store custom artifacts and Resource Manager templates](https://docs.microsoft.com/en-us/azure/lab-services/devtest-lab-add-artifact-repo)

## Final Notes

Be patient - the Terraform deployment is triggered independently from the ARM provisioning that is managed by DevTestLab itself. Means, the status of DevTestLab Environment provisioning status isn't reflecting the Terraform provisiong status. The latter is done by the created TFRunner container instance that is created by the ARM template.

Is it perfect - definitely NO. Currently there is no processing for Terraform output variables included. Means, output values that are created by the Terraform runbook are not reported back in a way that you could use them for further processing (e.g. use them as part of your CI/CD pipeline). In theory this is doable, but that needs some special handling inside the TFRunner shell script! 