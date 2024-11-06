param name string = 'myservicebus'
param location string = resourceGroup().location

resource servicebus 'Microsoft.ServiceBus/namespaces@2021-11-01' = {
  name: name
  location: location
  sku: {
    tier: 'Standard'
    name: 'Standard'
  }
  properties: {
    disableLocalAuth: false // Can use SAS authentication. Alternatively force AAD.
  }
}

resource namespaceAuthorizationRule 'Microsoft.ServiceBus/namespaces/AuthorizationRules@2021-11-01' = {
  parent: servicebus
  name: 'OverallManageSendListen'
  properties: {
    rights: [ 'Manage', 'Send', 'Listen' ]
  }
}
