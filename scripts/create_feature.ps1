# $args[0] := name of project
$featureName = $args[0]
$featuresDir = "$PWD\lib\features"
$packageName = (get-item $pwd).Name

# del feature directory if exists allready
if (Test-Path $featuresDir\$featureName\) {
    $answer = Read-Host "It seams like the feature $featureName allready exists. Are you sure you want to proceed? [Y/N]"
    if ($answer -eq 'y') { 
        Remove-Item $featuresDir\$featureName\ -Recurse -Force
    } else {
        Exit
    }
    
}

# create directories
Write-Output "Setting up directory tree..."
New-Item -Path $featuresDir\$featureName\ -Name "controllers" -ItemType "directory"
New-Item -Path $featuresDir\$featureName\ -Name "services"    -ItemType "directory"
New-Item -Path $featuresDir\$featureName\ -Name "models"      -ItemType "directory"
New-Item -Path $featuresDir\$featureName\ -Name "data"        -ItemType "directory"
New-Item -Path $featuresDir\$featureName\ -Name "components"  -ItemType "directory"

$controllerName = $featureName+"FeatureController.dart"
$viewName       = $featureName+"FeatureView.dart"

# copy templates
Write-Output "Copying templates..."
Copy-Item $PSScriptRoot\..\templates\FeatureController.dart  -Destination $featuresDir\$featureName\controllers
Copy-Item $PSScriptRoot\..\templates\FeatureView.dart        -Destination $featuresDir\$featureName

# replace placeholders
Write-Output "Replacing placeholders..."
Get-ChildItem -Path $featuresDir\$featureName -Recurse -Filter *.dart |
Foreach-Object {
    (Get-Content $_.FullName).replace('__NAME__', $featureName) | Set-Content $_.FullName
}

# rename files
Write-Output "Renameing files..."
Rename-Item -Path "$featuresDir\$featureName\controllers\FeatureController.dart"  -NewName "$featuresDir\$featureName\controllers\$controllerName"
Rename-Item -Path "$featuresDir\$featureName\FeatureView.dart"                    -NewName "$featuresDir\$featureName\$viewName"

# Done!
Write-Output " "
Write-Output "Helper is done!"
Write-Output " "
Write-Output "Do not forget to import the Feature in the main.dart!"
Write-Output " "
Write-Output "  $ import 'package:$packageName/features/$featureName/$viewName';"
Write-Output "  $ import 'package:$packageName/features/$featureName/controllers/$controllerName';"
Write-Output " "
Write-Output "  "$featureName"FeatureController _"$featureName"FeatureController = "$featureName"FeatureController();"
Write-Output "  "$featureName"FeatureView _"$featureName"FeatureView = "$featureName"FeatureView(controller = _"$featureName"FeatureController);"