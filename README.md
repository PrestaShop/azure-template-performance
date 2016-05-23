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
   type  string   
   description Username for the Ansible Control Virtual Machine and provisoning  
  
 - **sshKeyData**
   type string  
   description Public key for SSH authentication  
    
  - **ubuntuOSVersion**  
   type string  
     description  The Ubuntu version for the VM. This will pick a fully patched image of this given Ubuntu version. Allowed values:14.04.4-LTS, 16.04.0-LTS  
   
  - **frVmSize**  
    type string  
    description "Instance size for Web Front VMs  
     
  - **numberOfFront**  
   type int  
   description "Number of Front nodes to create >=2  
     
  - **backVmSize**  
    type string  
    description "Instance size for Web Front VMs Minimum Standard_A0  

  - **numberOfBack**   
    type int  
    description "Number of Back nodes to create >=2  
    

### front.json


## Variables definition
### azuredeploy.json

### front.json
