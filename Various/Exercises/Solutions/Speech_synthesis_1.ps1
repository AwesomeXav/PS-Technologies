add-type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$speak.Rate = 0
$speak.SelectVoiceByHints("male")

$lastboottime = (Get-WmiObject -Class Win32_OperatingSystem -ComputerName .).LastBootUpTime
$sysuptime = (Get-Date)-[System.Management.ManagementDateTimeconverter]::ToDateTime($lastboottime)

[string]$Formateduptime = ""

If ($sysuptime.days -gt "0") {$Formateduptime += [string]$sysuptime.Days + " Days "}
If ($sysuptime.hours -gt "0") {$Formateduptime += [string]$sysuptime.Hours + " Hours "}
If ($sysuptime.Minutes -gt "0") {$Formateduptime += [string]$sysuptime.Minutes + " Minutes "}
If ($sysuptime.Seconds -gt "0") {$Formateduptime += [string]$sysuptime.Seconds + " Seconds "}

$speak.Speak("Your current system up time is")
$speak.Speak($Formateduptime)
