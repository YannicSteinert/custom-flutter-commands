$featureName = $args[0]
$apiPath = $args[1]
$projectDir = $pwd
$outputDir = "lib/features/$featureName/services"

# check if feature exists
if (-Not (Test-Path $projectDir\lib\features\$featureName)) {
    Write-Output "It seams like the feature does not exist."
    Write-Output "Exiting..."
    Exit
}

# create swagger file directory
if (-Not (Test-Path $projectDir/swagger)) {
    New-Item -Path $projectDir -Name "swagger" -ItemType "directory" | Out-Null
}

# Check if swagger file exist
if (Test-Path $projectDir\swagger\api_$featureName.yaml -PathType Leaf) {
    $answer = Read-Host "It seams like a swagger_parser.yaml file allready exists. Are you sure you want to proceed? [Y/N]"
    if ($answer -eq 'y') { 
        Remove-Item $projectDir\swagger\api_$featureName.yaml -Recurse -Force
    } else {
        Exit
    }
}

# copy swagger template
Write-Output "Copying templates..."
Copy-Item $PSScriptRoot\..\templates\swagger_parser.yaml  -Destination $projectDir\swagger

# replace placeholders
Write-Output "Replacing placeholders..."
(Get-Content $projectDir\swagger\swagger_parser.yaml).replace('__IN_PATH__', $apiPath)     | Set-Content $projectDir\swagger\swagger_parser.yaml
(Get-Content $projectDir\swagger\swagger_parser.yaml).replace('__OUT_PATH__', $outputDir)  | Set-Content $projectDir\swagger\swagger_parser.yaml

# rename files
Write-Output "Renameing files..."
Rename-Item -Path "$projectDir\swagger\swagger_parser.yaml"  -NewName "$projectDir\swagger\api_$featureName.yaml"

# run swagger
Write-Output "$projectDir\swagger\api_$featureName.yaml"
dart run swagger_parser:generate -f $projectDir\swagger\api_$featureName.yaml

# Done!
Write-Output " "
Write-Output "Helper is done!"
