# Deploy PrestaShop Via ansible

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FPrestaShop%2Fazure-template-performance%2Fmaster%2FmainTemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FPrestaShop%2Fazure-template-performance%2Fmaster%2FmainTemplate.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>


       ┌────────────────────────────────────────┐        ┌───────────┐
       │               LB-80/443                │        │    22     │
       └────────────────────────────────────────┘        ├───────────┤
       ┌───────────┐  ┌───────────┐  ┌───────────┐       │Control VM │
       │ Front #1  │  │ Front #2  │  │ Front #n  │       │  Ansible  │
       │  Apache   │  │  Apache   │  │  Apache   │       │           │
       │  PHP-FPM  │  │  PHP-FPM  │  │  PHP-FPM  │       └───────────┘
       ├─────┬─────┤  ├─────┬─────┤  ├─────┬─────┤                    
       │ dd1 │ dd2 │  │ dd1 │ dd2 │  │ dd1 │ dd2 │                    
       │raid │raid │  │raid │raid │  │raid │raid │                    
       │soft │soft │  │soft │soft │  │soft │soft │                    
       ├─────┴─────┴──┴─────┴─────┴──┴─────┴─────┤                    
       │              csync2/lsyncd              │                    
       └─────────────────────────────────────────┘                    
                                                                   
       ┌───────────┐  ┌───────────┐  ┌───────────┐                    
       │  Back #1  │  │  Back #2  │  │  Back #n  │                    
       │   MySQL   │  │MySQL Slave│  │MySQL Slave│                    
       │  Master   │  │           │  │           │                    
       ├─────┬─────┤  ├─────┬─────┤  ├─────┬─────┤                    
       │ dd1 │ dd2 │  │ dd1 │ dd2 │  │ dd1 │ dd2 │                    
       │raid │raid │  │raid │raid │  │raid │raid │                    
       │soft │soft │  │soft │soft │  │soft │soft │                    
       └─────┴─────┘  └─────┴─────┘  └─────┴─────┘                    




### Microsoft Azure Marketplace Solution Templates - Validation Criteria for Virtual Machine based offers
### Check list fot the project

####**Templates Parameters**

1.	[Template parameters **MUST NOT** include allowedValues for the following parameter types:]  
	*	[x] Virtual Machine Size  
	*	[x] Storage Account Type 
	*	[x] Location
  
2.	[Templates **MUST NOT** define default values for the following parameters:]  
	*	[x] Storage Account Name
	*	[x] Domain Name Label

3.	Templates authentication related parameters **MUST** set Default Values as following:
	*	[x] SSH Key needs a default value blank if the solution also support Passw authentication 
	*	[x] Password needs a default value blank if the solution also support SSH Key

4.	[x] [The `apiVersion` specified for a resource type **MUST** be either be the latest version or have a date within 12 months of publishing.]

5.	[x] [All `apiVersion` references for a given resource type **MUST** use the same API.]

6.  [x] All usage of the providers function **MUST** use an explicit `apiVersion` [v1.1]

7.  [x] Templates **MUST** provide a templateBaseUrl variable for any base URL depend asset  [v1.1]

8.  [x] [Template solutions using `virtualMachines/extensions` **MUST** use protected settings when passing secrets such as passwords to those extensions]

9.  [x] [Parameters passed into templates that represent secrets such as passwords **MUST** use the type `securestring `]  

10. [x] When using extensions (ex. CustomScriptForLinux)  autoUpgradeMinorVersion **MUST** be set to true.[v1.1]  

11. [ ] When using a custom images MUST use production SingleVMs offers, no preview(staged) ones  [v1.2] 


####**Compute**

12. [x] [All `imageReferences` for virtual machines or virtual machine scale sets **MUST** use images that are available in the Azure Marketplace or core platform images.]
13. [x] [All `imageReferences` for virtual machines or virtual machine scale sets that do not belong to the marketplace publisher **MUST** specify `latest` for the `version` property.]
14. [x] [All Linux VMs created that support the use of SSH **MUST** support using public key authentication for any provisioned user.]

####**Storage**

15. [x] [Templates **MUST** take account of `storageAccounts` throughput constraints and deploy across multiple `storageAccounts` where necessary.]
16. [ ] [Where `storageAccounts` are used for the purpose of backup or snapshotting of data `Microsoft.Authorization/locks` **MUST** be used to prevent accidental deletion of those accounts.]
17. [x] [Templates creating new `storageAccounts` that creates storage names **MUST** generate unique `name` properties for each account created.](README.md#12-templates-creating-new-storageaccounts-must-generate-unique-name-properties-for-each-account-created)[v1.1]

####**Networking**

18.	[x] [If a template creates any new publicIPAddresses then it MUST have an output section that provides details of the fully qualified domain created.]
19.	[x] [`publicIPAddresses` assigned to a Virtual Machine Instance **MUST** only be used when these are required for application purposes, for connectivity to the resources for debug, management or administrative purposes either `inboundNatRules`, `virtualNetworkGateways` or a jumpbox should be used.]
20. [x] [Templates creating new `publicIPAddresses` that creates domain names label in the templates, **MUST** generate unique `domainNameLabel` properties for each address created.]

###**Recommended** — these are recommended requirements to deploy VM Based solution templates into the Azure marketplace, however they may be discounted where appropriate.

1.	[x] Templates **SHOULD** offer multiple sizes of deployments to cover common customer scenarios.
2.	[x] Multi-tier applications **SHOULD** deploy multiple Virtual Machines for each tier into Availability Sets and configure update and fault domains as appropriate.
3.	[ ] Templates **SHOULD** offer premium storage as an option for both OS and data disks.
4.	[ ] Applications using VMs local disk for durable data **SHOULD** be configured to take regular back-ups to durable storage to reduce the impact of data loss.
5.	[x] Linux based solutions **SHOULD** offer the ability to provision password based authentication in addition to using an SSH Key.
6.	[x] Templates **SHOULD** be optimized to minimize deployment times.
7.	[x] If a template creates any `publicIPAddresses` then it **SHOULD** also support the use of pre-existing ones.
8.	[x] Templates **SHOULD** include `networkSecurityGroups` to restrict traffic within `virtualNetworks` and to and from the Internet.
9.	[x] Templates **SHOULD** include `virtualMachines/diagnosticSettings` for each virtual machine created.
10. [ ] Where a provisioned application uses the virtual machines local disk for **durable data** it **SHOULD** replicate that data at least 3 times across at least 3 fault domains.
11.	[x] Where a template solution creates resources that are optional then it **SHOULD** use the new or existing pattern
