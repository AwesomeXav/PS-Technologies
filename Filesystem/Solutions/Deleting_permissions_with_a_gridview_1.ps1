$folder = "c:\testfolder\morgan freeman"

# get the ACL, disable inheritance and copy the existing permissions
$acl = Get-Acl $folder
$acl.SetAccessRuleProtection($true, $true)
Set-Acl -AclObject $acl -Path $folder

# get the ACES
$aces = $acl.Access

# show in gridview, and remove
$aces | Out-GridView -PassThru | ForEach-Object { $_; $acl.RemoveAccessRule($_) }

# store to folder (or file)
Set-Acl -AclObject $acl -Path $folder
