# filtering categories
$folder = Get-Item "c:\tmp\Backgrounds\oneFolder"
$filteredfolder = "c:\tmp\Backgrounds\filteredFolder"

if(-not $filteredfolder.Exists)
{
md $filteredfolder
}

$categories = Get-ChildItem $folder -File | Group-Object { $_.Name.Substring(0,$_.Name.IndexOf("-")) } | Select-Object Name, Count

$selectedcategories = $categories | Out-GridView -Title "Select the categories you want out" -PassThru

foreach($selectedcategorie in $selectedcategories)
{
Get-ChildItem -Path $folder -Filter "*$($selectedcategorie.name)*" |
Move-Item -Destination $filteredfolder
}
