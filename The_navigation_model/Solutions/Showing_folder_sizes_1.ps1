$folder = $home

$size = (Get-ChildItem $folder -Recurse -Force -ErrorAction SilentlyContinue| Measure-Object -Property length -Sum).sum
$size = $size/1MB
"{0} `t`t {1:N2} MB" -f $folder, $size

Get-ChildItem $folder -Recurse | Measure-Object -Property length -Sum |
Format-Table @{label="folder";expression={$folder}},`
@{label="size (in MB)";expression={$_.sum/1MB};format="N2";Alignment="right"} -AutoSize

# the difference in both values is because the first uses -Force and the second doesn't
