Get-WmiObject Win32_Desktop | format-list *
Get-WmiObject Win32_Desktop | select-object * -ExcludeProperty __*
