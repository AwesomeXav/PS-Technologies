New-PSDrive -Name tst -PSProvider FileSystem -Root "C:\tmp"
dir tst:
# close and reopen: drive is removed

New-Item $profile -Force
'New-PSDrive -Name tst -PSProvider FileSystem -Root "C:\tmp"' | Out-File $profile
# -Force on Out-File doesn't work like -Force on New-Item...

# close and reopen: drive remains (or comes back...)
( Get-Item $profile ).DirectoryName

Remove-Item -Path ( Get-Item $profile ).DirectoryName -Recurse
