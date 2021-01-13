function ValidateGPSBabel
{
	[Cmdletbinding()]
	param()
	
	$x=Get-ChildItem GPSBabel -ErrorAction Ignore
	if ($x -eq $null)
	{
		Write-Verbose "Extracting GPS Babel";
		Expand-7Zip -ArchiveFileName .\GPSBabel.7z -TargetPath GPSBabel
	}	
	else
	{
		Write-Verbose "GPS babel already extracted.";
	}
}

function ConvertTcX(){
	[Cmdletbinding()]
	param(
		[string]$Path
	)
	
	Write-Verbose "Convert $Path"
	
	$targetFile=$Path -replace ".tcx", ".gpx"
	
	$targetFileExists=Get-ChildItem $targetFile -ErrorAction Ignore
	if($targetFileExists -ne $null)
	{
		throw "Target file $targetFile exists."
	}

	$fileExe = "$PSScriptRoot\GPSBabel\gpsbabel.exe"
	& $fileExe  -i gtrnctr -f $Path -o gpx -F $targetFile	
}

function Convert {
	[Cmdletbinding()]
	param(
		[string]$Path
	)

	$tcxs=Get-ChildItem -Path $Path -Filter *.tcx
	foreach($tcx in $tcxs)
	{
		ConvertTcx($tcx.FullName)
	}
}


function ConvertTcx2Gpx {
	[Cmdletbinding()]
	param(
		[string]$Path
	)
	
	Write-Verbose "Hello";
	
	ValidateGPSBabel
	Convert $Path 
}