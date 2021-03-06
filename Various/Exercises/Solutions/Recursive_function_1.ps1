Function Get-LastWriteTime([System.IO.DirectoryInfo]$folder)
{
$lastWrite = $folder.LastWriteTime

Foreach($item in (Get-ChildItem -Path $folder.fullName) )
{
if($item.PSIsContainer)
{
$date = Get-LastWriteTime $item
}
else
{
$date = $item.LastWriteTime
}
if($date -gt $lastWrite)
{
$lastWrite = $date
}
}
return $lastWrite
}

Get-LastWriteTime (Get-Item c:\tmp)

# (Get-Item c:\tmp).LastWriteTime = (get-date).AddMonths(-1)
