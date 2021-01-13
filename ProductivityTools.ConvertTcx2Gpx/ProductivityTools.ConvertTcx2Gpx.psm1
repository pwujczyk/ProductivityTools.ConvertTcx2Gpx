
function Get7zPath{
	return "$PSScriptRoot\GPSBabel.7z"
}

function ValidateGPSBabel
{
	[Cmdletbinding()]
	param()
	
	$gpsBabelPath=Get7zPath
	$directory=Get-ChildItem "$PSScriptRoot\GPSBabel" -ErrorAction Ignore
	if ($directory -eq $null)
	{
		$zip=Get-ChildItem $gpsBabelPath -ErrorAction Ignore
		if($zip -eq $null)
		{
			Write-Verbose "Downloading GPS Babel."
			Invoke-WebRequest -Uri "https://github.com/pwujczyk/ProductivityTools.ConvertTcx2Gpx/raw/master/ProductivityTools.ConvertTcx2Gpx/GPSBabel.7z" -OutFile $gpsBabelPath
		}
		else
		{
			Write-Verbose "GPS babel already downloaded.";
		}
		
		Write-Verbose "Extracting GPS Babel from $gpsBabelPath";
		
		$targetPath="$PSScriptRoot\GPSBabel"
		Write-Verbose "Extracting GPS Babel to $targetPath";
		Expand-7Zip -ArchiveFileName $gpsBabelPath -TargetPath $targetPath
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


function Convert-Tcx2Gpx {
	[Cmdletbinding()]
	param(
		[string]$Path
	)
	
	Write-Verbose "Hello";
	
	ValidateGPSBabel
	Convert $Path 
}