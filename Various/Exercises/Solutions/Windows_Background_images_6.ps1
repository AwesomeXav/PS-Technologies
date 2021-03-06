# creating variables
$folder = Get-Item "C:\tmp\Backgrounds\oneFolder"
$baseFolder = "c:\tmp\Backgrounds\bysize"

$allImages = Get-ChildItem $folder -File


# move files
foreach($image in $allImages)
{
$size = (Get-Dimensions $image.FullName).Dimensions

if($size -ne [String]::Empty)
{
[Void][System.IO.Directory]::CreateDirectory($baseFolder + "\" + $size)
$image.MoveTo($baseFolder + "\" + $size + "\" + $image.Name)

}
}

# show number of files per folder
Get-ChildItem $baseFolder -Recurse -File | Group-Object Directory | Sort-Object Count -Descending | Format-Table Count, @{name="Folder";expression={$_.Name.Substring($_.Name.LastIndexOf("\")+1)}}


# the function to get the dimensions
# https://blogs.technet.microsoft.com/heyscriptingguy/2014/02/06/use-powershell-to-find-metadata-from-photograph-files/
# https://gallery.technet.microsoft.com/scriptcenter/get-file-meta-data-function-f9e8d804
# read, but don't use because it runs to slow...

# https://blogs.technet.microsoft.com/pstips/2015/02/22/filtering-files-by-their-metadata-extended-properties/


function Get-Dimensions($filePath)
{
# 31: Dimensions
# 169: width
# 171: heigt

$oShell = New-Object -ComObject Shell.Application
$FileItem = Get-Item -Path $filePath

$oFolder = $oShell.Namespace($FileItem.DirectoryName)
$oItem = $oFolder.ParseName($FileItem.Name)

$FileMetaData = New-Object PSObject

# check dimension
$props = New-Object -TypeName PSObject

# You can read properties 1..288, but it will take longer
Foreach($i in (31,169,171))
{
$ExtPropName = $oFolder.GetDetailsOf($oFolder.Items, $i)
$ExtValName = $oFolder.GetDetailsOf($oItem, $i)

if (-not (Get-Member -inputobject $props -name "ExtPropName" -Membertype Properties) -and ($ExtPropName -ne ""))
{
# ($_.ToString() +  ":" + $ExtPropName + ": "+ $ExtValName)
$props | Add-Member -MemberType NoteProperty -Name $ExtPropName -Value $ExtValName
}

}

#New-Object PSObject -Property $props
$oShell = $null

return $props
}

# Get-Dimensions C:\tmp\Backgrounds\oneFolder\Animals-06ca0db6-2b47-4816-869e-19fe846d77f5_17.jpg | Get-Member
