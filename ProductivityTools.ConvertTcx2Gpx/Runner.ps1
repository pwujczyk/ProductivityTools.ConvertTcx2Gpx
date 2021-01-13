clear
cd $PSScriptRoot
Import-Module .\ProductivityTools.ConvertTcx2Gpx.psm1 -Force 

ConvertTcx2Gpx -Path "c:\Users\pwujczyk\Desktop\endomondo-2020-12-08 - Copy\Workouts\" -Verbose 
