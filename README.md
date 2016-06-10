# Deploy PrestaShop Via ansible

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fherveleclerc%2Farm-lamp%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fherveleclerc%2Farm-lamp%2Fmaster%2Fazuredeploy.json" target="_blank">
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