function Select-First{
[CmdletBinding(DefaultParameterSetName='DefaultParameter', HelpUri='https://go.microsoft.com/fwlink/?LinkID=113387', RemotingCapability='None')]
param(
    [Parameter(ValueFromPipeline=$true)]
    [psobject]
    ${InputObject},

    [Parameter(ParameterSetName='DefaultParameter', Position=0)]
    [Parameter(ParameterSetName='SkipLastParameter', Position=0)]
    [System.Object[]]
    ${Property},

    [Parameter(ParameterSetName='SkipLastParameter')]
    [Parameter(ParameterSetName='DefaultParameter')]
    [string[]]
    ${ExcludeProperty},

    [Parameter(ParameterSetName='DefaultParameter')]
    [Parameter(ParameterSetName='SkipLastParameter')]
    [string]
    ${ExpandProperty},

    [Parameter(ParameterSetName='DefaultParameter')]
    [ValidateRange(0, 2147483647)]
    [int]
    ${Skip})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Select-Object', [System.Management.Automation.CommandTypes]::Cmdlet)
        $PSBoundParameters['First']=1
        $scriptCmd = {& $wrappedCmd @PSBoundParameters }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process
{
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end
{
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
<#

.ForwardHelpTargetName Microsoft.PowerShell.Utility\Select-Object
.ForwardHelpCategory Cmdlet

#>
}