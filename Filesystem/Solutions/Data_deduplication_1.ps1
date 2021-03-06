Get-WindowsFeature "*deduplication*" |  Install-WindowsFeature
$drive = "D:"
Enable-DedupVolume -Volume $drive
Get-DedupVolume
Get-DedupSchedule
Set-DedupVolume -Volume $drive -MinimumFileAgeDays 0
Start-DedupJob -Volume $drive -Type Optimization
Get-DedupJob
Get-DedupStatus
