$moduleRoot = Split-Path -Path $MyInvocation.MyCommand.Path

Write-Verbose "Importing Functions"
# Import everything in the functions folder
Get-ChildItem "$moduleRoot\Functions\*.ps1" | 
    ForEach-Object { . $_.FullName ; Write-Verbose $_.FullName}
