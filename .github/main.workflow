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

workflow "Create Feature in AzBoards" {
  on = "issues"
  resolves = ["Create Azure Boards Work Item"]
}

workflow "Update Feature comments in AzBoards" {
  on = "issue_comment"
  resolves = ["Create Azure Boards Work Item"]
}

action "Create Azure Boards Work Item" {
  uses = "mmitrik/github-actions/boards@master"
  env = {
    AZURE_BOARDS_TYPE = "Feature"
    AZURE_BOARDS_ORGANIZATION = "AzureBoardsTeam"
    AZURE_BOARDS_PROJECT = "actions-demo"
  }
  secrets = ["AZURE_BOARDS_TOKEN"]
}
