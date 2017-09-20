# MotherOfPosh
Create an empty module template

# how to create
Fork/Download MotherOfPosh.ps1 and run
```powershell
$name = "MySUperModuleName"
.\MotherOfPosh.ps1 -Name $name

# outputs under c:/powershell-development/Posh-$name
```

## How to debug
* Add functions under $PSScriptRoot/functions
* Run $PSScriptRoot/Posh-$ModuleName.sandbox.ps1

# Open Source:
I did this for fun, take a copy and do whatever :)
