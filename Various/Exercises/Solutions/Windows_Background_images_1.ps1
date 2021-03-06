# files to main folder
$basefolder = Get-Item "C:\tmp\Backgrounds"
$destinationfolder = Get-Item "c:\tmp\Backgrounds\oneFolder"

if(-not $destinationfolder.Exists)
{
md $destinationfolder
}

foreach($file in (Get-ChildItem -Path $basefolder -File -Recurse))
{
$newname = $file.DirectoryName.Substring($file.DirectoryName.LastIndexOf("\")+1) + "-" + $file.name

Move-Item -Path $file.FullName -Destination "$destinationfolder\$newname"
}
