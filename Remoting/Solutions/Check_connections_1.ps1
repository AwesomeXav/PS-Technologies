# -includeusername requires run as administrator
Get-Process -IncludeUserName | Group-Object UserName
# look for the username that is connected remotely

Get-Process -IncludeUserName | Where-Object UserName -like "*theremoteuser*"

# kill all remote sessions
Get-Process "wsmprovhost" | kill
