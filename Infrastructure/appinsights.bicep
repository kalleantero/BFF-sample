@description('Name of the Application Insights')
param applicationInsightsName string

@description('Application Insight Location.')
param applicationInsightsLocation string = 'West Europe'

@description('Tags.')
param tags object

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: applicationInsightsName
  location: applicationInsightsLocation
  kind: 'web'
  properties: {
    Application_Type: 'web'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
  tags:tags
}

output instrumentationKey string = appInsights.properties.InstrumentationKey
