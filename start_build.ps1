#!/usr/bin/pwsh -Command

if(Test-Path -Path "${PWD}/vcpkg") {
    echo "vcpkg folder exist."
    Set-Location ${PWD}/vcpkg
	echo "current path: ${PWD}"
	git.exe pull
} else {
    git.exe clone https://github.com/microsoft/vcpkg
    Set-Location ${PWD}/vcpkg
    echo "current path: ${PWD}"
    ./bootstrap-vcpkg.bat
}

./vcpkg.exe install