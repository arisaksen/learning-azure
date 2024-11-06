param aksClusterName string = 'aks-cluster-123'
param blobStorageDataContributorId string = 'ba92f5b4-2d11-453d-a403-e96b0029c9fe' // Blob storage data contributor (read, write, delete)
param serviceBusDataReceiverId string = '4f6d3b9b-027b-4f4c-9142-0e5a2a2247e0' // Servicebus data reciever role id (read)
param serviceBusDataSenderId string = '69a216fc-b8fb-44d8-bc22-1f3c2cd27a39' // Servicebus data sender role id (write)
//param serviceBusDataSenderId string = newGuid()
param githubActionDeployment bool = false

resource aks 'Microsoft.ContainerService/managedClusters@2024-05-01' existing = {
  name: aksClusterName
}

resource blobStorageRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: resourceGroup()
  name: blobStorageDataContributorId
}

resource serviceBusReceiverRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: resourceGroup()
  name: serviceBusDataReceiverId
}
resource serviceBusSenderRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  scope: resourceGroup()
  name: serviceBusDataSenderId
}

// Github runner does not have permissions to create managed identities
resource roleAssignmentBlobStorage 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (!githubActionDeployment){
  name: guid(blobStorageRoleDefinition.id, subscription().id)
  properties: {
    principalId: aks.identity.principalId
    roleDefinitionId: blobStorageRoleDefinition.id
    principalType: 'ServicePrincipal'
  }
}
resource roleAssignmentServiceBusReceiver 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (!githubActionDeployment){
  name: guid(serviceBusReceiverRoleDefinition.id, subscription().id)
  properties: {
    principalId: aks.identity.principalId
    roleDefinitionId: serviceBusReceiverRoleDefinition.id
    principalType: 'ServicePrincipal'
  }
}
resource roleAssignmentServiceBusSenderAKS 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (!githubActionDeployment){
  name: guid(serviceBusSenderRoleDefinition.id, subscription().id)
  properties: {
    principalId: aks.identity.principalId
    roleDefinitionId: serviceBusSenderRoleDefinition.id
    principalType: 'ServicePrincipal'
  }
}
