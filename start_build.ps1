#!/usr/bin/pwsh -Command

if(Test-Path -Path "${PWD}/vcpkg") {
    Write-Output "vcpkg folder exist."
    Set-Location ${PWD}/vcpkg
	Write-Output "current path: ${PWD}"
	#git.exe pull
} else {
    git.exe clone https://github.com/microsoft/vcpkg
    Set-Location ${PWD}/vcpkg
    Write-Output "current path: ${PWD}"
    ./bootstrap-vcpkg.bat
}


if(-not $env:Qt5_DIR) {
    # Attempt to set Qt5_DIR to the default path for the windows installation
    DEFAULT_QT_INSTALLATION_PATH="C:\Qt\5.15.2\msvc2019_64\lib\cmake"
    if(Test-Path DEFAULT_QT_INSTALLATION_PATH) {
        $env:Qt5_DIR=DEFAULT_QT_INSTALLATION_PATH
    }
    else {
        Write-Error "Failed to find system installation of Qt5."
        Write-Error "Specify Qt5_DIR in the environment or install Qt 5.15.2 for MSVC2019 64bit in the default location"
        exit -1
    }
}

$env:VCPKG_KEEP_ENV_VARS="Qt5_DIR"

./vcpkg.exe install --overlay-triplets=../triplets --overlay-ports=../overlay_ports/qt5-imageformats --overlay-ports=../overlay_ports/qt5-tools --overlay-ports=../overlay_ports/qt5-xmlpatterns