Import-Module ActiveDirectory
New-PSDrive -name AD -PSProvider activedirectory -root "" -server "192.168.250.109" -Credential cursusdom.local\Jochen

# save the path where everything will be happening
$domain = "dc=cursusdom,dc=local"
$pathInAD = "ou=MyName,ou=Acme,$domain"

# create an OU
New-ADOrganizationalUnit -Name "MyName" -Path "ou=Acme,$domain"

# 10 new users, called testX
(1..10) | ForEach-Object { New-ADUser `
        -Name ("MyName" + $_) `
        -Path $pathInAD `
        -SamAccountName ("MyName" + $_) `
        -AccountPassword (convertto-securestring -asplaintext "R1234-56" -force) `
        -enabled $true }

# or move some of the actors...
# in this case all actors whose name begins with M
Get-ADUser -SearchBase "ou=Users,ou=Acme,$domain" -Filter { Name -like "M*" } |
    Move-ADObject -TargetPath $pathInAD

# create a global group
New-ADGroup -Name "GG_MyUsers" -GroupCategory Security -GroupScope Global -Path $pathInAD

# add members
Get-ADGroup "GG_MyUsers" | Add-ADGroupMember -Members (get-aduser -SearchBase $pathInAD -Filter *)

# or...
Add-ADGroupMember -Identity "GG_MyUsers" -Members (get-aduser -SearchBase $pathInAD -Filter *)

# or...
Add-ADGroupMember -Identity (Get-ADGroup "GG_MyUsers") -Members (get-aduser -SearchBase $pathInAD -Filter *)

# or... (but don't)
get-aduser -SearchBase $pathInAD -Filter * | ForEach-Object { Add-ADGroupMember -Identity (Get-ADGroup "GG_MyUsers") -Members $_ }

# or...
Get-ADUser -SearchBase $pathInAD -Filter * | Add-ADPrincipalGroupMembership -MemberOf (Get-ADGroup "GG_MyUsers")

# Empty / fill the profilepath of all users in your OU.
get-aduser -SearchBase $pathInAD -Filter * | Set-ADUser -ProfilePath "c:\temp"
get-aduser -SearchBase $pathInAD -Filter "name -like 'Morgan Freeman'" | Set-ADUser -ProfilePath "c:\otherTemp"
get-aduser -SearchBase $pathInAD -Filter *  -Properties Name, ProfilePath | ft Name, ProfilePath

# Using "-remove" to remove the profilepath, although "-clear" is better
get-aduser -SearchBase $pathInAD -Filter * | Set-ADUser -Remove @{ProfilePath = "c:\temp"}
# notice: Butch's profilepath isn't removed!
get-aduser -SearchBase $pathInAD -Filter *  -Properties Name, ProfilePath |
    ForEach-Object { Set-ADUser $_ -Remove @{ProfilePath = $_.ProfilePath} }
# ... and now it is. Drawback is longer, slightly more difficult cmdlet-string

# remove the property "ProfilePath"
get-aduser -SearchBase $pathInAD -Filter * | Set-ADUser -Clear ProfilePath
get-aduser -SearchBase $pathInAD -Filter *  -Properties Name, ProfilePath | ft Name, ProfilePath
