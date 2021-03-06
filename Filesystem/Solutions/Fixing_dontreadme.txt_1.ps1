$thefile = "c:\tmp\dont read me.txt"

# What we did:
New-Item -Path $thefile -ItemType file
Set-Content -Path $thefile -Value "Supersecret"

$acl = Get-Acl -Path $thefile
$acl.SetAccessRuleProtection($true, $false)
$acl | Set-Acl -Path $thefile

# How we'll fix it:
$acl = Get-Acl -Path $thefile

# Define ACE
$user = $env:USERDOMAIN + "\" + $env:USERNAME
$rights = [System.Security.AccessControl.FileSystemRights]"FullControl"
$access = [System.Security.AccessControl.AccessControlType]::Allow
$inherit = [System.Security.AccessControl.InheritanceFlags]::None

$propagation = [System.Security.AccessControl.PropagationFlags]::InheritOnly
$accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule($user,$rights,$inherit,$propagation,$access)

# Add ACE to ACL and save
$acl.AddAccessRule($accessrule)
$acl | Set-Acl -Path $thefile
# problem: has to be run as administrator
# https://connect.microsoft.com/PowerShell/feedback/details/789418/unable-to-set-acl-using-set-acl-when-not-admin-on-acl-protected-folder

# now you have acces to the file
# next: enable inheritance, and remove the ace
$isProtected = $false # means: turn on inheritance
$preserveInheritance = $true # is ignored
$acl.SetAccessRuleProtection($isProtected, $preserveInheritance)
$acl.RemoveAccessRule($accessrule)
$acl | Set-Acl -Path $thefile
