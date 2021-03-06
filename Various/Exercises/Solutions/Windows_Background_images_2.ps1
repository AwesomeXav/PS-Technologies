# counting per type
$folder = Get-Item "c:\tmp\Backgrounds\oneFolder"

Get-ChildItem $folder -File |
Group-Object { $_.Name.Substring(0,$_.Name.IndexOf("-")) } |
Sort-Object Count -Descending |
Format-table Count, Name
