param serviceBusName string = 'myservicebus'
param incomingTopicName string = 'upload'

resource servicebus 'Microsoft.ContainerService/managedClusters@2024-05-01' existing = {
  name: serviceBusName
}

resource topicsResource 'Microsoft.ServiceBus/namespaces/topics@2021-11-01' = {
  name: incomingTopicName
  parent: servicebus
}

