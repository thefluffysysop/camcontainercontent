#!/usr/bin/env pwsh
<#
.AUTHOR
Created by Robert Kloosterhuis - CAM IT Solutions
(based on work by  Ruud Harreman , CAM IT)
19-03-2019

.EXPLANATION
This script is meant to be run from inside CAM|Container. 
This script demonstrates the ability to pick up locally variable (local to the docker host)  parameters that may differ between locations/docker hosts. 
From the perspective of the script and the Docker image, the parameter file is REMOTE, as in -outside- of the image, instead of contained in the image

.VARIABLES


.EXAMPLE


.CHANGELOG
0.1 - Initial
#> 

Write-Host "Begin script $PSCommandPath"

# Load the remote parameters file
$P=&("/remotecontent/parameters/parameters.ps1")
#$P=&("c:\scripts\camcontainer_testing\parameters.ps1")

# Get variables from the remote parameters file

$LocalDockerHost = $P.LocalDockerHost
$vCenter1 = $P.vSphereServer
$LocalColor = $P.localcolor
#TODO - Replace hardcoded vSPhere Creds with PSCredential Objects dervied from encrypted keyfiles
$vSphereUsername = $P.vSphereUsername
$vSpherePassword = $P.vSpherePassword



#Script Start

Write-Host "----------------------------------------------------------------------------" -ForegroundColor $LocalColor 
Write-Host "DEMO - Executing a LOCAL PS script using CAM|CONTAINER!" -ForegroundColor $LocalColor 
Write-Host "This script runs from INSIDE the CAM|CONTAINER but uses REMOTE parameters to feed the script" -ForegroundColor $LocalColor 
Write-Host "For example, this script will now connect to vCenter and get some VSCA information, " -ForegroundColor $LocalColor 
Write-Host "using variables for credentials and vCenter FQDN, that it will get " -ForegroundColor $LocalColor 
Write-Host "from the file /remotecontent/parameters/parameters.ps1" -ForegroundColor $LocalColor 
Write-Host "This 'parameters' file could be different in every location the container is run" -ForegroundColor $LocalColor 
Write-Host "----------------------------------------------------------------------------" -ForegroundColor $LocalColor 
Write-Host "LOCAL INFORMATION" -ForegroundColor $LocalColor 
Write-Host "LocalColor: $LocalColor" -ForegroundColor $LocalColor 
Write-Host "vCenter: $vCenter1" -ForegroundColor $LocalColor 
Write-Host "LocalDockerHost: $LocalDockerHost" -ForegroundColor $LocalColor
Write-Host "vSphere Username to use: $vSphereUsername" -ForegroundColor $LocalColor
Write-Host "----------------------------------------------------------------------------" -ForegroundColor $LocalColor 



# Connect to the VI Server
Write-Host "Connecting to vCenter using Connect-VIserver and Connect-CISServer" -ForegroundColor $LocalColor 
Connect-VIserver -Server $vCenter1 -user $vSphereUsername -password $vSpherePassword -force
Connect-CISServer -Server $vCenter1 -user $vSphereUsername -password $vSpherePassword -force

#Running commands get-VAMISummary and get-VAMIHealth which are already included in vmware/powerclicore
Write-Host "Running commands get-VAMISummary and get-VAMIHealth which are already included in vmware/powerclicore" -ForegroundColor $LocalColor 
get-VAMISummary
get-VAMIHealth

Write-Host "End Script $PSCommandPath"


