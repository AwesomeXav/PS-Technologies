$basefolder = "c:\tmp"

$permission = $env:USERNAME, "FullControl", "Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission

foreach ($newfolder in @("TF", "SF", "F", "TF-SF-F", "TF-SF", "TF-F", "SF-F") ) {
    $acl = New-Item -Path $basefolder -Name $newfolder -ItemType directory | Get-Acl

    $acl.AddAccessRule($accessRule)
    $acl | Set-Acl -Path "$basefolder\$newfolder"
}

# change the inheritance in the GUI manually...

# get the permissions for that user
$newACEs = @()

foreach ($newfolder in @("TF", "SF", "F", "TF-SF-F", "TF-SF", "TF-F", "SF-F") ) {
    $acl = Get-Acl -Path "$basefolder\$newfolder"

    foreach ($ace in $acl.Access) {
        $ace.IdentityReference
        if ($ace.IdentityReference -like "*$env:USERNAME*") {
            Add-Member -InputObject $ace -MemberType NoteProperty -Name "folder" -Value "$newfolder"
            $newACEs += $ace
        }
    }
}

$newACEs | ft folder, InheritanceFlags, PropagationFlags
