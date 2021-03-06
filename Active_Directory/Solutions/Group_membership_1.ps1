# creating more groups
New-ADGroup -Name "DL_folder_RW" -GroupCategory Security -GroupScope DomainLocal -Path $pathInAD
New-ADGroup -Name "GG_MyUsers2" -GroupCategory Security -GroupScope Global -Path $pathInAD
New-ADGroup -Name "DL_folder_FC" -GroupCategory Security -GroupScope DomainLocal -Path $pathInAD
New-ADGroup -Name "DL_folder_RX" -GroupCategory Security -GroupScope DomainLocal -Path $pathInAD

Add-ADGroupMember -Identity (Get-ADGroup "DL_folder_RW") -Members (Get-ADGroup "GG_MyUsers")
Add-ADGroupMember -Identity (Get-ADGroup "GG_MyUsers") -Members (get-aduser -SearchBase $pathInAD -Filter * )
Add-ADGroupMember -Identity (Get-ADGroup "DL_folder_FC") -Members (Get-ADGroup "GG_MyUsers2")
Add-ADGroupMember -Identity (Get-ADGroup "GG_MyUsers2") -Members (get-aduser -SearchBase $pathInAD -Filter { name -like "*u*" })
Add-ADGroupMember -Identity (Get-ADGroup "DL_folder_RX") -Members (Get-ADGroup -filter "name -like 'GG_MyUsers*'")

# trying out recursive searching

# show "memberOf" for all users"
get-aduser -SearchBase $pathInAD -Filter * -Properties memberOf | ft Name, memberOf

# find the distinguished name for the groups
Get-ADGroup "GG_MyUsers" | Get-Member -Name "*distin*"
(Get-ADGroup "GG_MyUsers").DistinguishedName

Get-ADUser -filter "memberOf -RecursiveMatch '$((Get-ADGroup "GG_MyUsers").DistinguishedName)'"

# https://blogs.technet.microsoft.com/heyscriptingguy/2014/11/25/active-directory-week-explore-group-membership-with-powershell/
# Windows PowerShell variable subexpression: $()

# get the users of a (DL-)group that only has (G-)groups as members
Get-ADUser -filter " memberOf -RecursiveMatch '$((Get-ADGroup "DL_folder_RW").DistinguishedName)'"
Get-ADUser -filter " memberOf -RecursiveMatch '$((Get-ADGroup "DL_folder_FC").DistinguishedName)'"

# get all groups a user is member of
# Get-ADPrincipalGroupMembership should fix this, but doesn't work...
$MorganFreeman = get-aduser -SearchBase $pathInAD -Filter "name -like 'Morgan Freeman'"

Get-ADObject (Get-ADGroup "GG_MyUsers").DistinguishedName -Properties memberOf | ft name, memberOf

Get-MyMemberOf $butch.DistinguishedName -Verbose

function Get-MyMemberOf() {
    <#
.SYNOPSIS
Get groupmembership recursively.

.DESCRIPTION
Get groupmembership recursively of any AD-object. Returns an array of groupnames.

.PARAMETER objectDN
DistinguishedName of object.

.EXAMPLE
$butch = get-aduser -SearchBase $pathInAD -Filter "name -like 'butch*'"
Get-MyMemberOf($butch.DistinguishedName)
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $true)]
        [string]$objectDN
    )
    $object = Get-ADObject $objectDN -Properties name, memberOf
    $groups = $object.MemberOf

    Write-Verbose $object.Name

    $returnArr = $groups

    foreach ($group in $groups) {
        Write-Verbose $group
        # Get-ADObject $group -Properties memberOf, Name, DistinguishedName
        $returnArr += Get-MyMemberOf($group)
        # Get-MyMemberOf($group)
    }

    return $returnArr | Select-Object -Unique
}

Get-Help Get-MyMemberOf -full
