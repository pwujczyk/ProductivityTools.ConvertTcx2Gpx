function ValidateGPSBabel
{
	[Cmdletbinding()]
	param()
	
	$x=Get-ChildItem GPSBabel -ErrorAction Ignore
	if ($x -eq $null)
	{
		Expand-7Zip -ArchiveFileName .\GPSBabel.7z -TargetPath GPSBabel
	}	
}


function Dof {
	[Cmdletbinding()]
	param()
	
	Write-Output "Hello";
	Write-Verbose "Hello";
}