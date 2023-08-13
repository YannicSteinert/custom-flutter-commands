@echo off
setlocal

if "%~1"=="create:project" goto CREATE_PROJECT
if "%~1"=="create:feature" goto CREATE_FEATURE
if "%~1"=="create:swagger" goto CREATE_SWAGGER
if "%~1"=="create:help" goto CREATE_HELP
if "%~1"=="help" goto CREATE_HELP
if "%~1"=="?" goto CREATE_HELP

echo "Exit!"
exit /b



:CREATE_HELP
    echo "create:project -name <Name>"
    echo "create:feature -name <Name>"
    echo "create:swagger -feature <feature name> -path <openapi.json>"
    echo "create:help"

    exit /b

:CREATE_PROJECT
    if "%~2"=="" goto CREATE_MISSING_PARAMETER
    echo "[FLUTTER HELPER] Creating new project..."
    Powershell.exe -executionpolicy remotesigned -File  %~dp0\scripts\create_project.ps1 %2
    exit /b

:CREATE_FEATURE
    if "%~2"=="" goto CREATE_MISSING_PARAMETER
    echo "[FLUTTER HELPER] Creating new feature..."
    Powershell.exe -executionpolicy remotesigned -File  %~dp0\scripts\create_feature.ps1 %2
    exit /b

:CREATE_SWAGGER
    if "%~2"=="" goto CREATE_MISSING_PARAMETER
    if "%~3"=="" goto CREATE_MISSING_PARAMETER
    if "%~4"=="" goto CREATE_MISSING_PARAMETER
    if "%~5"=="" goto CREATE_MISSING_PARAMETER
    
    if "%~2"=="-feature"    set "featureName=%~3"
    if "%~2"=="-path"       set "apiPath=%~3"
    if "%~4"=="-feature"    set "featureName=%~5"
    if "%~4"=="-path"       set "apiPath=%~5"

    echo "[FLUTTER HELPER] Creating new swagger..."
    Powershell.exe -executionpolicy remotesigned -File  %~dp0\scripts\swagger_feature.ps1 %featureName% %apiPath%
    exit /b


:CREATE_MISSING_PARAMETER
    echo You are missing a Parameter!
    echo "helper create:<type> <name>"
    exit /b
