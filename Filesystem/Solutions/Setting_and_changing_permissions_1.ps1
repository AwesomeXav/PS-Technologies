# create folder
$folder = "c:\TestFolder"
New-Item -Path $folder -ItemType directory

# Cycle through ACE's
# Get-Acl $folder | Format-List *
$acl = Get-Acl $folder
$aces = $acl.access

foreach ($ace in $aces) {
    Write-Host $ace.IdentityReference " has " `
        $ace.FileSystemRights $ace.AccessControlType `
        "`ninherited: " $ace.isinherited `
        "`nInheritance flags: " $ace.InheritanceFlags `
        "`nPropagation flags: " $ace.PropagationFlags "`n"
}

# URL: 'How to handle NTFS Folder permissions'
# MSDN: library 'Access mask'

# Copy contents
Copy-Item -Path c:\tmp\* -Destination $folder -Recurse

# Disable inheritance
$acl = Get-Acl $folder
$acl.SetAccessRuleProtection($True, $False)
# first true: is protected from inheritance
# second true: copy the existing permissions as local, non-inherited permission

# $acl | Set-Acl $folder -> not yet. This is an empty ACL, you don't want to apply it before adding another ACE

# quick and dirty:
$permission = $env:USERNAME, "FullControl", "Allow"

$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $folder

$a = Get-Acl $folder
$a | Format-List
$aces = $a.Access

foreach ($ace in $aces) {
    Write-Host $ace.IdentityReference " has " `
        $ace.FileSystemRights $ace.AccessControlType `
        "`ninherited: " $ace.isinherited `
        "`nInheritance flags: " $ace.InheritanceFlags `
        "`nPropagation flags: " $ace.PropagationFlags "`n"
}

Get-Acl $folder | Set-Acl c:\tmp
