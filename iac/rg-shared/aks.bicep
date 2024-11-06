param clusterName string = 'aks-cluster-123'
param location string = resourceGroup().location

// https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-automatic-deploy?pivots=bicep
resource aks 'Microsoft.ContainerService/managedClusters@2024-05-01' = {
  name: clusterName
  location: location
  sku: {
		name: 'Automatic'
  		tier: 'Standard'
  }
  properties: {
    agentPoolProfiles: [
      {
        name: 'systempool'
        count: 2
        vmSize: 'Standard_DS4_v2'
        osType: 'Linux'
        mode: 'System'
      }
    ]
  }
  identity: {
    type: 'SystemAssigned'
  }
}

resource dapr 'Microsoft.KubernetesConfiguration/extensions@2023-05-01' = {
  name: 'dapr'
  scope: aks
  properties: {
    extensionType: 'microsoft.dapr'
    scope: {
      cluster: {
        releaseNamespace: 'dapr-system'
      }
    }
    autoUpgradeMinorVersion: true
  }
}
