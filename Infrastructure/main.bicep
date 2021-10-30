@description('Name of the App Service Plan')
param appServicePlanName string

@description('The SKU of App Service Plan.')
param appServicePlanSku string = 'S1'

@allowed([
  'Win'
  'Linux'
])
@description('Select the OS type to deploy.')
param appServicePlanPlatform string

@description('Name of the UI App Service')
param uiAppServiceName string

@description('Name of the API App Service')
param apiAppServiceName string

var defaultTags = {
  Team: 'DevTeam1'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: resourceGroup().location
  sku: {
    name: appServicePlanSku
  }
  kind: ((appServicePlanPlatform == 'Linux') ? 'linux' : 'windows')
  tags:defaultTags
}

module uiAppService './webapp.bicep' = {
  name: 'uiAppService'
  params: {
    appServiceName: uiAppServiceName
    appServicePlanId: appServicePlan.id
    location: resourceGroup().location
    tags: defaultTags
  }
}

module apiAppService './webapp.bicep' = {
  name: 'apiAppService'
  params: {
    appServiceName: apiAppServiceName
    appServicePlanId: appServicePlan.id
    location: resourceGroup().location
    tags: defaultTags
  }
}
