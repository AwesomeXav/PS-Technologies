$env:path = $env:path + ";c:\tmp"
# or
set-item -path env:path -value ($env:path + ";c:\tmp")
