clear
cd $PSScriptRoot
Import-Module .\ProductivityTools.TCX2GPXConverter.psm1 -Force 

ConvertTcx2Gpx -Path "c:\Users\pwujczyk\Desktop\endomondo-2020-12-08 - Copy\Workouts\" -Verbose 
