function Set-VMVLan
{
    <#
    .Synopsis
        Assigns a VM to a vLan  
    .DESCRIPTION
        Assigns a VM to a vLan
    .EXAMPLE
        $VM = Get-VM v500-test
        Set-VLan -VM $VM -vLan 500
    .EXAMPLE
        Get-VM v500* | Set-VLan -vLan 500
    .INPUTS
        Accepts a single VM or a collection of VMs or VM names.   
    .NOTES
        Can be used to bulk assign VMs to a network vLan.  
        
        If more than one vLan is on that host, then the first one is used. 
    #>
    [cmdletbinding()]
    param(

        [Parameter(
            Mandatory         = $true,
            Position          = 0,
            ValueFromPipeline = $true
            )]
        [Alias("ComputerName","Name")]
        [ValidateNotNullOrEmpty()]
        $VM,
         [Parameter(
            Mandatory         = $true,
            Position          = 1,
            ValueFromPipelineByPropertyName = $true
            )]
        [ValidateNotNullOrEmpty()]
        [int]$VLan
    )

    process
    {
        foreach($Node in $VM)
        {
            if(!$Node.VMHost)
            {
               $Node = Get-VM $Node 
            }

            $PortGroup = $Node | 
                Foreach-Object{Get-VirtualPortGroup -VMHost $_.VMHost} | 
                Where-Object{$_.VLanId -eq $VLan} 

            if($PortGroup.count -gt 1)
            {
                Write-Warning "Multiple vlans with ID $vlan on host. Only the first one was used. Please verify it is the correct one"
                $PortGroup = $PortGroup[0]
            }

            $Node | Get-NetworkAdapter | Set-NetworkAdapter -Portgroup $PortGroup -confirm:$false
        }
    }
}

