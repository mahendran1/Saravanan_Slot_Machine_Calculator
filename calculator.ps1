$file = 'C:\Users\ahd0\Desktop\Slot machine\testfile.txt'
$content = gc $file
$splitfile = "$env:USERPROFILE\splitfile.txt"
# Spliting only 2 number to identify the result for 2nd place
foreach($number in $content)
{
$numberarr = [int[]](($number -split '') -ne '')
$number2 = $numberarr[1]
$number3 = $numberarr[2]
$splitnumber = "$number2"+"$number3"
$splitnumber | Out-File -FilePath $splitfile -Append
}
# Calculating result for 1st place
$timestamp = Get-Date -Format o | foreach {$_ -replace ":", "."}
Get-Content $file | Group-Object -noelement | select Name, Count | Export-Csv "$env:USERPROFILE\desktop\First_Price_$timestamp.csv" -NoTypeInformation
# Calculating result for 2nd place
$timestamp2 = Get-Date -Format o | foreach {$_ -replace ":", "."}
Get-Content $splitfile | Group-Object -noelement | select Name, Count | Export-Csv "$env:USERPROFILE\desktop\Second_Price_$timestamp.csv" -NoTypeInformation
Remove-Item $splitfile -Force
