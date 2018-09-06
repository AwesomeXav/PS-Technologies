(get-date).year .. (get-date).addyears(1).year |
ForEach-Object { (get-date -day 1 -month 7 -year $_ ) - (get-date).date } |
Where-Object { $_ -gt 0 } |
Select-Object -First 1
