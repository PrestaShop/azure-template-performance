# Deploy PrestaShop Via ansible

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fherveleclerc%2Farm-lamp%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fherveleclerc%2Farm-lamp%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>


## Parameters Definition
### azuredeploy.json

 - **hcUsername**  
   type        : string   
   description : Username for the Ansible Control Virtual Machine and provisoning  
  
 - **sshKeyData**
   type         : string  
   description  : Public key for SSH authentication  
    
  - **ubuntuOSVersion**  
   type         : string  
   description  : The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version. Allowed values:14.04.4-LTS, 16.04.0-LTS  
   
  - **frVmSize**  
    type        : string  
    description : Instance size for Web Front VMs  
     
  - **numberOfFront**  
   type         : int  
   description  : Number of Front nodes to create >=2  
     
  - **backVmSize**  
    type        : string  
    description : Instance size for Web Front VMs Minimum Standard_A0  

  - **numberOfBack**   
    type        : int  
    description : Number of Back nodes to create >=2  
    

### front.json


## Variables definition
### azuredeploy.json

  - templatesBaseURL  
    value       : https://raw.githubusercontent.com/herveleclerc/arm-lamp/master/nested/  
    description : Base URL for Nested ARM  
    
  - frontTemplateURL  
    value       : templatesBaseURL+'/front.json'  
    description : Location of Front ARM Nested Template  
    
  - backTemplateURL 
    value       : templatesBaseURL+'/back.json'  
    description  Location of Back ARM Nested Template   
    
  - frFaultDomainCount  
    value       : 3  
    description :   Number of fault Domain for front Load Balancer  
    
  - frUpdateDomainCount  
    value 5    
    description : Number of Fault Domain Count for front Load Balancer  
    
  - dnsNameForAnsiblePublicIP  
    value       : 'hc00'+resourceGroup().name  
    description : FQDN for Ansible Control VM  
    
  - dnsserver  
    value       : 8.8.8.8  
    description : Default DNS Server  
    
  - location  
    value       : resourceGroup().location  
    description : Resource group location  
    
  - imagePublisher  
    value       : Canonical  
    description : Linux Image Publisher  
    
  - imageOffer  
    value       : UbuntuServer  
    description : Image Offer  
    
  - hcOSDiskName  
    value       : hcosdisk  
    description : Disk Name for Ansible Control VM  
  - keyStorageAccountName  
    value       : 'key'+resourceGroup().name  
    description : Storage account name for private and public keys of VM keys  
    
  - keyStorageAccountType  
    value       : Standard_LRS  
    description : Storage Type for private and public keys of VM keys   
    
  - hcNicName  
    value       : hcVnic  
    description : Nic Name for Ansible Control VM   
    
  - virtualNetworkName 
    value       : vNet+resourceGroup().name  
    description : Virtual Network Name  
    
  - vnetID  
    value       : resourceId(Microsoft.Network/virtualNetworks + variables('virtualNetworkName')  
    description : Virtual Network Name  ID  
    
  - addressPrefix  
    value       : 10.0.0.0/16  
    description : IP range for Virtual Network  
  - subnetCIDR  
    value       : .0/24  
    description : CIDR for subnets  
    
  - hcSubnetRoot    
    value       : 10.0.0  
    description : Admin Subnet Prefix  
    
  - frSubnetRoot  
    value       : 10.0.2  
    description : FRONT Subnet Prefix 
    
  - bkSubnetRoot  
    value       : 10.0.4  
    description : BACK Subnet Prefix  
    
  - hcSubnetName  
    value       : hcSubnet  
    description : ADMIN Subnet Name  
    
  - hcSubnetPrefix 
    value       : hcSubnetRoot+subnetCIDR  
    description : ADMIN Subnet with CIDR  
    
  - frSubnetName  
    value       : frSubnet  
    description : FRONT Subnet Name
    
  - frSubnetPrefix 
    value       : frSubnetRoot+subnetCIDR  
    description : FRONT  Subnet with CIDR  
    
  - bkSubnetName  
    value       : bkSubnet  
    description : BACK Subnet Name  
    
  - bkSubnetPrefix 
    value       : bkSubnetRoot+subnetCIDR  
    description : BACK   Subnet with CIDR  
    
  - assetsStorageAccountId  
    value       : resourceId(keyStorageAccountName+Microsoft.Storage/storageAccounts+keyStorageAccountName  
    description : Storage account ID  
     
  - hcStorageAccountName  
    value       : hc+resourceGroup().name 
    description : Storage Account Name for Control VM   
    
  - hcStorageAccountType  
    value       : Standard_LRS  
    description :
  - frStorageAccountName  
    value       : [concat('fr', resourceGroup().name)]  
    description :
  - frStorageAccountType  
    value       : Standard_LRS  
    description :
  - bkStorageAccountName  
    value       : [concat('bk', resourceGroup().name)]  
    description :
  - bkStorageAccountType  
    value       : Standard_LRS  
    description :
  - frAvailabilitySetName  
    value       : [concat('frav', resourceGroup().name)]  
    description :
  - bkAvailabilitySetName  
    value       : [concat('bkav', resourceGroup().name)]  
    description :
  - hcPublicIPAddressName  
    value       : hcPublicIP  
    description :
  - hcPublicIPAddressType  
    value       : Dynamic  
    description :
  - hcVmStorageAccountContainerName  
    value       : vhds  
    description :
  - hcVmName  
    value       : [concat('ans', resourceGroup().name)]  
    description :
  - frVmName  
    value       : [concat('web', resourceGroup().name)]  
    description :
  - bkVmName  
    value       : [concat('bdd', resourceGroup().name)]  
    description :
  - hcSubnetRef 
    value       : vnetID'),'/subnets/',variables('hcSubnetName'))]  
    description :
  - hcVmSize  
    value       : Basic_A0  
    description :
  - hcNetworkSecurityGroupName  
    value       : hcSG  
    description :
  - frNetworkSecurityGroupName  
    value       : frSG  
    description :
  - bkNetworkSecurityGroupName  
    value       : bkSG  
    description :
  - sshKeyPath  
    value       : [concat('/home/',parameters('hcUsername'),'/.ssh/authorized_keys')]  
    description :
  - scriptsBaseUrl  
    value       : https://raw.githubusercontent.com/herveleclerc/arm-lamp/master/scripts/  
    description :
  - ansiblePlaybookLocation  
    value       : deploy-prestashop.yml  
    description :
  - customScriptDeployFile  
    value       : deploy.sh  
    description :
  - customScriptDeployUrl 
    value       : scriptsBaseUrl'),variables('customScriptDeployFile'))]  
    description :
  - customScriptAnsibleCommand  
    value       : [concat('bash ',variables('customScriptDeployFile'))]  
    description :
  - ansiblePlaybookUrl 
    value       : scriptsBaseUrl'),variables('ansiblePlaybookLocation'))]  
    description :
  - pythonAzureScriptUrl 
    value       : scriptsBaseUrl'),'WriteSSHToPrivateStorage.py')]  
    description :
  - paramsSubnets 
    value       : hcSubnetRoot'),' ',variables('frSubnetRoot'),' ',variables('bkSubnetRoot'),' ')]  
    description :
  - paramsNbHosts  
    value       : [concat(parameters('numberOfFront'),' ',parameters('numberOfBack'))]  
    description :
  - paramsNames 
    value       : hcVmName'),' ',variables('frVmName'),' ',variables('bkVmName'))]  
    description :
  - paramsDeploy  
    value       : [concat(parameters('hcUsername'),' ',variables('paramsSubnets'),' ',variables('paramsNbHosts'),' ',variables('paramsNames'))]  
    description :
  - apiVersion":{
    - resources":{
      - deployments  2015-01-01"
      },
    - network  2015-05-01-preview  
    - storage  2015-05-01-preview  
    - compute  2015-06-15  
    - deployment  2016-02-01"
  



### front.json
TDB
