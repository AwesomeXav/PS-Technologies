Get-CimInstance -Namespace root\cimv2\power -ClassName win32_PowerPlan | Format-List *

Get-CimInstance -Namespace root\cimv2\power -ClassName Win32_PowerPlan |
Format-Table ElementName, IsActive -AutoSize

(Get-CimClass -Namespace root\cimv2\power -ClassName Win32_PowerPlan).CimClassMethods

$plan = Get-CimInstance -Namespace root\cimv2\power -ClassName Win32_PowerPlan | Where ElementName -eq "High performance"
Invoke-CimMethod -InputObject $plan -MethodName activate
