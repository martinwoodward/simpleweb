workflow "Publish to Azure Blob" {
  on = "push" 
  resolves = ["Azure CLI"]
}

action "Azure Login" {
  uses = "Azure/github-actions/login@master"
  env = {
    AZURE_SUBSCRIPTION = "RMPM"
  }
  secrets = ["AZURE_SERVICE_PASSWORD", "AZURE_SERVICE_TENANT", "AZURE_SERVICE_APP_ID"]
}

action "Azure CLI" {
  uses = "Azure/github-actions/cli@master"
  env = {
    AZURE_SCRIPT = "az --version"
  }
  needs = ["Azure Login"]
}
