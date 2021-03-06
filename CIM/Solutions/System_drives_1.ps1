$drive = @{label="Drive";Expression={$_.DeviceID}}
$Volumename = @{label="Volumename";Expression={$_.VolumeName}}
$Percentage = @{label="Percentage free space";Expression={$_.Freespace/$_.Size};FormatString="P2";alignment="Center"}
Get-CimInstance Win32_LogicalDisk | Format-Table $drive, $Volumename, $Percentage -AutoSize

$drive = @{label="Drive";Expression={$_.Root}}
$Volumename = @{label="Volumename";Expression={$_.Description}}
$Percentage = @{label="Percentage free space";Expression={$_.Free/$_.Used};FormatString="P2";alignment="Center"}
Get-PSDrive -PSProvider FileSystem | Format-Table $drive, $Volumename, $Percentage -AutoSize
