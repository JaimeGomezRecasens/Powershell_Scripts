## This script get a list of servers from a file, copy .msi file and .mst file to a temporary folder in remote computer and then installs it

$computerList = gc "C:\XXXXXX\list_Servers.txt"
$msi_file = 'C:\XXXXXX.msi'
$mst_file = 'C:\XXXXXXX.mst'
#$session = New-PSSession -ComputerName $computerName

foreach ($computer in $computerList) {
	$session = New-PSSession -ComputerName $computer
	
	$destinationFolder = "\\$computer\C$\Temp"
	
	Copy-Item -Path $msi_file -ToSession $session -Destination 'c:\Temp\XXXXX.msi'
	Copy-Item -Path $mst_file -ToSession $session -Destination 'c:\Temp\XXXXX.mst'
	
	Invoke-Command -Session $session -ScriptBlock {
    msiexec /i "C:\XXXXX.msi" TRANSFORMS="C:\XXXXX.mst" /qb
	}

	Remove-PSSession $session
}
