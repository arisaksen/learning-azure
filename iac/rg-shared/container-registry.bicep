param name string = 'mycontainerreg'
param location string = resourceGroup().location

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2022-12-01' = {
  name: name
  location: location
  sku: {
    name: 'Standard'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    adminUserEnabled: false
  }
}
