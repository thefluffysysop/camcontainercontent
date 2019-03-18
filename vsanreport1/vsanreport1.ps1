#!/usr/bin/env pwsh
Write-Output "----------------------------------------------------------------------------"
Write-Output "CAMDEMO - Executing a LOCAL PS script using CAM|CONTAINER!"
Write-Output "This script runs from INSIDE the CAM|CONTAINER but uses REMOTE config to feed the script"
Write-Output "For example, this script will now connect to vCenter, "
Write-Output "using variables for credentials and vCenter FQDN, that it will get "
Write-Output "from the file /remotecontent/localparameters/localparameters.ps1"
Write-Output "This 'localparameters' file could be different in every location the container is run"
Write-Output "----------------------------------------------------------------------------"
get-command connect-viserver vcenter1.flufflap.local

