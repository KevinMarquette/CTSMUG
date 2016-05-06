
$newFunction = @'
function New-Function
{
    <#
    .SYNOPSIS

    .EXAMPLE
    New-Function -ComputerName server
    .EXAMPLE
 
    .NOTES

    #>
    [cmdletbinding()]
    param(
        # Pipeline variable
        [Parameter(
            Mandatory         = $true,
            HelpMessage       = ' ',
            Position          = 0,
            ValueFromPipeline = $true
        )]
        [Alias('Server')]
        [string[]]$ComputerName
    )

    process
    {
        foreach($node in $ComputerName)
        {
            Write-Verbose $node
        }
    }
}
'@
New-IseSnippet -Title "Cmdlet (Basic)" -Description "Basic Cmdlet" -Text $newfunction  -Force


$CmdletHelp = @"
<#
.SYNOPSIS

.EXAMPLE

.EXAMPLE
 
.NOTES

#>

"@

New-IseSnippet -Title "Cmdlet (simple help text)" -Description "Cmdlet (Help text)" -Text $CmdletHelp -CaretOffset 16 -Force


$CmdletParameterSimple = @'
# Param1 help description
[Parameter(
    Mandatory         = $false,
    HelpMessage       = " ",
    Position          = 0,
    ValueFromPipeline = $false,
    ValueFromPipelineByPropertyName = $true
    )]
[Alias("alias")]
[string[]]$ParamName
'@
New-IseSnippet -Title "Parameter simple" -Description "Simple Cmdlet Parameter list" -Text $CmdletParameterSimple -Force
