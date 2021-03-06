[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

# Get the destination

$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.ShowDialog() | Out-Null
$destination = $folderBrowser.SelectedPath

# if destination is C, select folders to put in CSV
if($destination -eq "C:\")
{
$input = [System.Windows.MessageBox]::Show('Select folders you want to backup. To end, select "C:\"','Select folders','Ok','Information')

$destinations = New-Object System.Collections.ArrayList($null)

do
{
$folderBrowser.ShowDialog() | Out-Null
$destinations.Add($folderBrowser.SelectedPath)
}
until($folderBrowser.SelectedPath -eq "C:\")

$destinations.Remove($folderBrowser.SelectedPath)

# write the CSV
$toExport = @()
foreach($dest in $destinations)
{
$obj = New-Object psobject
Add-Member -InputObject $obj -MemberType NoteProperty -Name "Folder" -Value $dest
$toExport += $obj
}

$toExport | Export-Csv "all folders.csv" -NoTypeInformation -Encoding UTF8

Write-Host "File created, exiting script."
exit
}

# Get the CSV-file

[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$fileBrowser = New-Object System.Windows.Forms.OpenFileDialog
$fileBrowser.filter = "CSV (*.csv)| *.csv"
$fileBrowser.ShowDialog() | Out-Null
$CSVfile = $fileBrowser.FileName

# Create logfile?

$input = [System.Windows.MessageBox]::Show('Create logfile?','Logfile','YesNo','Question')

if($input -eq 'Yes')
{
.\Backup-Folders.ps1 -destination $destination -CSV $CSVfile -createLOG
}
else
{
.\Backup-Folders.ps1 -destination $destination -CSV $CSVfile
}
