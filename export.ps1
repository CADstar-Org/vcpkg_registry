#!/usr/bin/pwsh -Command

$date = $args[0]
#$date = Get-Date -Format "yy-MM-dd-HH-mm"

if(Test-Path -Path "./vcpkg-export") {
    Remove-Item './vcpkg-export' -Recurse
}

New-Item './vcpkg-export/installed' -ItemType Directory

Copy-Item './vcpkg_installed\*' -Destination './vcpkg-export/installed' -Recurse
Copy-Item './vcpkg/scripts' -Destination './vcpkg-export' -Recurse
Copy-Item './vcpkg/.vcpkg-root' -Destination './vcpkg-export'

7z.exe a export-$date.7z .\vcpkg-export