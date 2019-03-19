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



# Load the script parameters
$P=&("remotecontent\parameters\parameters.ps1")
$P=&("c:\scripts\camcontainer_testing\parameters.ps1")


# Load the key
$key = Import-Clixml -Path ($p.Scriptpath+$p.CredKey)

# Get variables for this script

$vCenter1 = $P.vSphereServer
$LocalColor = $P.localcolor

#Script Start

Write-Output "----------------------------------------------------------------------------" -ForegroundColor $LocalColor 
Write-Output "DEMO - Executing a LOCAL PS script using CAM|CONTAINER!" -ForegroundColor $LocalColor 
Write-Output "This script runs from INSIDE the CAM|CONTAINER but uses REMOTE parameters to feed the script" -ForegroundColor $LocalColor 
Write-Output "For example, this script will now connect to vCenter, " -ForegroundColor $LocalColor 
Write-Output "using variables for credentials and vCenter FQDN, that it will get " -ForegroundColor $LocalColor 
Write-Output "from the file /remotecontent/parameters/parameters.ps1" -ForegroundColor $LocalColor 
Write-Output "This 'parameters' file could be different in every location the container is run" -ForegroundColor $LocalColor 
Write-Output "----------------------------------------------------------------------------" -ForegroundColor $LocalColor 
Write-Output "Local Information:" -ForegroundColor $LocalColor 
Write-Output "vCenter: $vCenter1" -ForegroundColor $LocalColor 
Write-Output "LocalDockerHost: $P.LocalDockerHost" -ForegroundColor $LocalColor 
Write-Output "LocalColor: $LocalColor " -ForegroundColor $LocalColor 
Write-Output "----------------------------------------------------------------------------" -ForegroundColor $LocalColor 


# Connect to the VI Server
Connect-VIserver -Server $connectto -Credential (load-CPSCredential -path ($p.Scriptpath+$p.CredvSphere) -key $key) -force


