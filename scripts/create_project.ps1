# $args[0] := name of project
$projectName = $args[0]
$projectDir  = "$PWD\"+$args[0]

# del feature directory if exists allready
if (Test-Path $projectDir) {
    $answer = Read-Host "It seams like the project $projectName allready exists. Are you sure you want to proceed? [Y/N]"
    if ($answer -eq 'y') { 
        Remove-Item $projectDir -Recurse -Force
    } else {
        Exit
    }
    
}

# wait for flutter to finish
flutter create --platforms=web $projectName

#check if flutter create worked
if (-not (Test-Path $projectDir/lib)) {
    Write-Output "An error occoured while running flutter create! Exiting script..."
    Exit
}


# Remove unnecessary files/dirs
Remove-Item $projectDir/lib -Recurse -Force | out-null
Remove-Item $projectDir/test -Recurse -Force | out-null

# create directories
Write-Output "Setting up directory tree..."
New-Item -Path $projectDir\lib\ -Name "controllers" -ItemType "directory"
New-Item -Path $projectDir\lib\ -Name "services"    -ItemType "directory"
New-Item -Path $projectDir\lib\ -Name "models"      -ItemType "directory"
New-Item -Path $projectDir\lib\ -Name "data"        -ItemType "directory"
New-Item -Path $projectDir\lib\ -Name "components"  -ItemType "directory"
New-Item -Path $projectDir\lib\ -Name "features"    -ItemType "directory"


# copy templates
Write-Output "Copying templates..."
Copy-Item $PSScriptRoot\..\templates\main.dart  -Destination $projectDir\lib

# Done!
Set-Location $projectDir
Write-Output " "
Write-Output "Helper is done!"
Write-Output " "
Write-Output "In order to add features to your application, type:"
Write-Output " "
Write-Output "  $ cd $projectName"
Write-Output "  $ helper create:feature <name>"