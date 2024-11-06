param name string = 'myrg'
param location string = 'northeurope'


// https://learn.microsoft.com/en-us/azure/templates/microsoft.resources/2023-07-01/resourcegroups?pivots=deployment-language-bicep
targetScope='subscription'
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: name
  location: location
}
