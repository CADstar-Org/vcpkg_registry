#!/usr/bin/pwsh -Command

if(Test-Path -Path "${PWD}/vcpkg") {
    echo "vcpkg folder exist."
	#git.exe pull
} else {
    git.exe clone https://github.com/microsoft/vcpkg
    vcpkg/bootstrap-vcpkg.bat
}

vcpkg/vcpkg.exe install --overlay-triplets=../triplets