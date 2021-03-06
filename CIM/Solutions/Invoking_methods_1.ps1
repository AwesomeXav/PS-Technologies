# https://blogs.technet.microsoft.com/heyscriptingguy/2014/01/30/invoking-cim-methods-with-powershell/

notepad

# Retrieve the Win32_Process instance for notepad.exe
$Notepad = Get-CimInstance -ClassName Win32_Process -Filter "Name = 'notepad.exe'"

# Invoke the Win32_Process.Terminate() method
Invoke-CimMethod -InputObject $Notepad -MethodName Terminate

# get all static methods:
(Get-CimClass -ClassName Win32_Process).CimClassMethods

# investigate the create-method
(Get-CimClass -ClassName Win32_Process).CimClassMethods['Create'].Parameters

# create an arguments-array
$Arguments = @{
CommandLine = 'notepad.exe'
CurrentDirectory = $null
ProcessStartupInformation = $null
};

# and call the method
Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments $Arguments
