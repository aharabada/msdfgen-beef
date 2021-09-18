# Builds msdfgen and copies the library into the dist-Directory

Write-Output "---- Building Library... ----"
Write-Output "----        DEBUG        ----"

devenv .\msdfgen\Msdfgen.sln /project Msdfgen /rebuild "Debug Library"

Write-Output "----       RELEASE       ----"

devenv .\msdfgen\Msdfgen.sln /project Msdfgen /rebuild "Release Library"

Write-Output "----    COPYING FILES    ----"

$debugInput = ".\msdfgen\x64\Debug Library\";
$debugOutput = ".\msdfgen-beef\dist\Debug-Win64\";
$releaseInput = ".\msdfgen\x64\Release Library\";
$releaseOutput = ".\msdfgen-beef\dist\Release-Win64\";

if(!(Test-Path $debugOutput))
{
    mkdir -Verbose $debugOutput
}

if(!(Test-Path $releaseOutput))
{
    mkdir -Verbose $releaseOutput
}

Copy-Item -Verbose -Path "$($debugInput)\msdfgen.lib" -Destination "$($debugOutput)msdfgen.lib"
Copy-Item -Verbose -Path "$($debugInput)\msdfgen.pdb" -Destination "$($debugOutput)msdfgen.pdb"

Copy-Item -Verbose -Path "$($releaseInput)\msdfgen.lib" -Destination "$($releaseOutput)msdfgen.lib"
Copy-Item -Verbose -Path "$($releaseInput)\msdfgen.pdb" -Destination "$($releaseOutput)msdfgen.pdb"
