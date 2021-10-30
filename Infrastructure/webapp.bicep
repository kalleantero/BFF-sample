@description('Name of the App Service Plan')
param appServiceName string

@description('ID of App Service Plan.')
param appServicePlanId string

@description('Location.')
param location string = 'West Europe'

@description('Tags.')
param tags object

module appInsights './appinsights.bicep' = {
  name: 'appinsights-${appServiceName}'
  params: {
    applicationInsightsName: 'appi-${appServiceName}'
    applicationInsightsLocation: location
    tags: tags
  }
}

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  properties:{
    serverFarmId: appServicePlanId
    siteConfig:{
      alwaysOn: true
      ftpsState: 'Disabled'
      netFrameworkVersion: 'v6.0'
      appSettings: [
        {
          'name': 'APPINSIGHTS_INSTRUMENTATIONKEY'
          'value': appInsights.outputs.instrumentationKey
        }     
      ]
    }
    httpsOnly: true    
  }
  tags:tags
}

output appServiceId string = appService.id


