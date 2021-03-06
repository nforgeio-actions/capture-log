#Requires -Version 7.0 -RunAsAdministrator
#------------------------------------------------------------------------------
# FILE:         action.ps1
# CONTRIBUTOR:  Jeff Lill
# COPYRIGHT:    Copyright (c) 2005-2021 by neonFORGE LLC.  All rights reserved.
#
# The contents of this repository are for private use by neonFORGE, LLC. and may not be
# divulged or used for any purpose by other organizations or individuals without a
# formal written and signed agreement with neonFORGE, LLC.

# Verify that we're running on a properly configured neonFORGE GitHub runner 
# and import the deployment and action scripts from neonCLOUD.
      
# NOTE: This assumes that the required [$NC_ROOT/Powershell/*.ps1] files
#       in the current clone of the repo on the runner are up-to-date
#       enough to be able to obtain secrets and use GitHub Action functions.
#       If this is not the case, you'll have to manually pull the repo 
#       first on the runner.
      
$ncRoot = $env:NC_ROOT
      
if ([System.String]::IsNullOrEmpty($ncRoot) -or ![System.IO.Directory]::Exists($ncRoot))
{
    throw "Runner Config: neonCLOUD repo is not present."
}
      
$ncPowershell = [System.IO.Path]::Combine($ncRoot, "Powershell")
      
Push-Location $ncPowershell | Out-Null
. ./includes.ps1
Pop-Location | Out-Null

try
{   
    # Process the log file.
      
    $path             = Get-ActionInput     "path"
    $type             = Get-ActionInput     "type"
    $group            = Get-ActionInput     "group"
    $success          = Get-ActionInputBool "success"
    $failOnError      = Get-ActionInputBool "fail-on-error"
    $keepShfbWarnings = Get-ActionInputBool "keep-shfb-warnings"
    $message          = Get-ActionInput     "A previous step failed"
      
    if ([System.String]::IsNullOrEmpty($group))
    {
        $group = "LOG-CAPTURE"
    }

    if ([System.String]::IsNullOrEmpty($path))
    {
        Write-ActionWarning("*** No build log path was passed.")
    }
    else
    {
        Write-ActionOutputFile $path $group $type -keepShfbWarnings $keepShfbWarnings
    }

    if (!$success -and $failOnError)
    {
        Write-ActionError $message
        exit 1
    }
}
catch
{
    Write-ActionException $_
    exit 1
}
