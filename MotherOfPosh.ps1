param(
  [string]$Name # name your module
)

if($Name -like "Posh-*"){
  $SplitName = $Name -split "-"
  $ModuleName = $SplitName[1]
}
else{
  $ModuleName = $Name
}

# create directories
$rootpath = "c:/powershell-development"
if(!(test-path $rootpath)){
  new-item -path $rootpath -itemtype directory
}
if(!(test-path $rootpath\$ModuleName)){
  new-item -path $rootpath\$ModuleName -itemtype directory
}
if(!(test-path $rootpath\$ModuleName\Functions)){
  new-item -path $rootpath\$ModuleName\Functions -itemtype directory
}

new-item -path "$rootpath\$ModuleName\Posh-$ModuleName.psd1" -itemtype file
new-item -path "$rootpath\$ModuleName\Posh-$ModuleName.psm1" -itemtype file
new-item -path "$rootpath\$ModuleName\Posh-$ModuleName.sandbox.ps1" -itemtype file

$GUID = [guid]::NewGuid()

$psd1 = "@{

# Script module or binary module file associated with this manifest.
RootModule = 'Posh-$ModuleName.psm1'

# Version number of this module.
ModuleVersion = '0.0.1.0'

# ID used to uniquely identify this module
GUID = '$GUID'

# Functions to export from this module
FunctionsToExport = '*'

# Cmdlets to export from this module
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

}"

$psm1 = '# load functions
  $functionFilter = Join-Path $PSScriptRoot "Functions"
  Get-ChildItem -Path $functionFilter -Filter "*.ps1" -Recurse |
  Foreach-Object {
      Write-Verbose "Loading function $($_.Name).."
      . $_.FullName
  }
'

$sandbox = 'Remove-Module $PSScriptRoot -Force -ErrorAction SilentlyContinue
Import-Module $PSScriptRoot -Verbose
cd $PSScriptRoot
'

add-content "$rootpath\$ModuleName\Posh-$ModuleName.psd1" $psd1
add-content "$rootpath\$ModuleName\Posh-$ModuleName.psm1" $psm1
add-content "$rootpath\$ModuleName\Posh-$ModuleName.sandbox.ps1" $sandbox
