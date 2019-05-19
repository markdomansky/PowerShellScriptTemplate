Function ${PLASTER_PARAM_FuncName} {
    <#
.SYNOPSIS
${PLASTER_PARAM_FuncName} ${PLASTER_PARAM_FuncDesc}

.DESCRIPTION
Detailed description of the script and what it is for.

.EXAMPLE
${PLASTER_PARAM_FuncName} -param1 "Value"
Give an example of common usage.  Repeat EXAMPLE as desired

.PARAMETER Param1
Short description of the parameter and how to use it.  Include PARAMETER for each parameter

.PARAMETER Param2
Short description of the parameter and how to use it.  Include PARAMETER for each parameter

.INPUTS
String
#.NET Framework object types that can be _piped_ in.  Repeat allowed inputs within single INPUTS

.OUTPUTS
String
#.NET Framework object types that will be returned.

.LINK
URI or name of related topic. repeat LINK and URI/name as desired/needed.

.NOTES
Version:          1.0
Author:           ${PLASTER_PARAM_FullName}
Creation Date:    ${PLASTER_PARAM_Date}
History:
    ${PLASTER_PARAM_Date} ${PLASTER_PARAM_Time}, 1.0, ${PLASTER_PARAM_FullName}, Initial Creation


This template is CC0/1.0 Public Domain and can be found at github.com/markdomansky/powershellscripttemplate
#note: This comment block MUST come before everything else.
#>
#requires -version 5.1 #3, #6
#remove extra # to enable a requires
##requires -runasadministrator
##requires -modules <module-name>,<module-name> #repeat as desired, replace <module-name> with @{ModuleName="X";ModuleVersion="1.0.0.0"} if you want specific versions
##requires -shellid <shellid>

#This PS1 script can be turned into a function by wrapping the entire script in "Function <functionname> {<full content of script including help block>}"

[CmdletBinding(SupportsShouldProcess = $True, ConfirmImpact = 'Medium')]
#SupportsShouldProcess=$true - forces acceptance of -Whatif and -Confirm
#ConfirmImpact='Medium' (Low, Medium (default), High) will prompt for action where $pscmdlet.shouldprocess is called - OPINION: Low for Get-, Medium for Set/Remove-, High for high-impact Set/Remove-
#$pscmdlet.ShouldProcess("target",["action"]) is run.  Returns true/false, generally only want for high impact actions (i.e. restart computer)
#TODO better explain confirmimpact, supportsshouldprocess
#DefaultParameterSetName="X" whatever parameterset used below
#HelpUri="Uri" used to store help documentation elsewhere: http://msdn.microsoft.com/en-us/library/dd878343(v=vs.85).aspx
#SupportsPaging=$true - adds First,Skip, IncludeTotalCount parameters automatically PSv3 req'd
#PositionalBinding=$false - default true, allows parameters by position, when false, all parameters must be defined by name (-computername "X")

#NOTE whatif, confirm, verbose, and debug are all passed through to sub-cmdlets/scripts called within the script.

param
(
    #Parameter Templates are at the bottom of the script

    [Parameter(Position = 0, Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName,
        HelpMessage = 'What computer name would you like to target?')]
    [ValidateNotNullOrEmpty()]
    [string]$Param1,

    [Parameter()]
    [switch]$Param2

) #/param

begin
{
    #$ErrorActionPreference = Stop #Stop, *Continue*, SilentlyContinue
    #$VerboseActionPreference = Continue #Stop, Continue, *SilentlyContinue*

    #do pre script checks, etc

} #/begin

process
{
    #$PSBoundParameters.containskey('') to determine if value was specified for parameter
    #switch ($pscmdlet.parametersetname) {"Group1" {} "Group2" {} }

    Write-Verbose "Beginning process loop"

    foreach ($p1 in $Param1)
    {
        Write-Verbose "Processing $p1"
        if ($PSCmdlet.ShouldProcess($p1, "copy files"))
        {
            Write-Output "$p1 - $Param2"
        }
    }

} #/process

end
{
    #useful for cleanup, or to write-output whatever you want to return to the user
} #/end

###############################################################
# Parameter Template
###############################################################
<#
    #For each ParameterSet, you must specify a Parameter block
    #Parameters with no ParameterSetName are available to ALL ParameterSets
    [Parameter(
        Position=0, #implicit parameter ordering
        Mandatory, #indicates a required parameter.  Can use multiple parameter sets to make optional in certain cases
        ParameterSetName="Group1", #If using ParameterSets (different groups of required parameters)
        ValueFromPipeline, #the piped inputs will be used here
        ValueFromPipelineByPropertyName, #the property name of the piped inputs will be used here ($files.PATH)
        HelpMessage='What computer name would you like to target?', #especially useful for mandatory, this will be the prompt presented.
        ValueFromRemainingArgument=$true #this pushes all remaining unassigned variables into this parameter.
    )]
    #mandatory, valuefrom* can have "=$true/$false" but like a switch, it's implicit. v2 requires explicit =$true/$false
    [SupportsWildcards()]
    [Alias('MachineName')] #Can use -MachineName in this example instead of Param1 and it will still be recognized, helpful for ValueFromPipelineByPropertyName.  Is array-based, so ('MachineName','ServerName') is valid.
    [ValidateCount(2,5)] #number of items in collection, if you provided 1 item or 6 items in an array, it would error.  Typically used with arrays [vartype[]]
    [ValidateLength(3,30)] #the length of the object. Typically for strings, if the string was 'AB', it would error
    [ValidatePattern("regexpattern")] #RegexPattern to match.  usually for string, must match the regex pattern equivalent to ($param -match $regex)
    [ValidateRange(1,100)] #typically a number, -1 or 1000 would error
    [ValidateScript({$_ -gt (10)})] #must return $true/$false, this would require the number to be greater than 10
    [ValidateSet('Input','Output','Both')] #any set of values you want here.  These are the only accepted values for this input.  Can also be effectively combined with arrays.  Not case sensitive.
    [ValidateNotNullOrEmpty()] #Common to use, Mandatory doesn't enforce content, only the existence of a parameter, this can be used to ensure the user provides something beyond $null or ""
    [ValidateNotNull()] #same as ValidateNotNullOrEmpty, but only prevents $null
    [AllowNull()] #effectively reverse of ValidateNotNullOrEmpty
    [AllowEmptyString()]
    [AllowEmptyCollection()]
    [string[]]$ComputerName, #accepts multiple, typically use a foreach in process{}
    [string]$ComputerName, #only one
#    common: [switch]/[boolean], [int]/[int32]/[byte]/[uint]/[uint64], [pscredential], [psobject], [float]/[double], [datetime] many others possible and most support [] within to accept multiple in an array.
#    can also specify any .NET object type (e.g. System.Generic.Collections.List)
#    note: switch and boolean are not treated the same, switches are called with -paramname[:$true/false] where boolean are called -paramname $true/$false
#    can always specify default values after the variable e.g. [string]$computername = $env:computername or (get-date) or most anything in powershell, but you can't see the other variables yet.  It can however reference variables in the parent scope.
#    DynamicParam is available, but an advanced topic not covered here.  see: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-5.1#dynamic-parameters
#>

