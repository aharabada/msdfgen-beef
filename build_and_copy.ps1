# Builds msdfgen and copies the library into the dist-Directory

$buildtype = $args[0]
$buildmode = $args[1]

Write-Output "----       MSDF (C++)      ----"

if ((!$buildtype) -or (!$buildmode))
{
    Write-Output "No build options specified..."
    Write-Output "Usage: build_and_copy.ps1 [build|rebuild] [debug|release|all]"
}
else
{
    $rebuildSwitch = ""

    if (($buildtype -eq "rebuild"))
    {
        $rebuildSwitch = "/rebuild"
    }
    elseif(($buildtype -eq "build"))
    {
        $rebuildSwitch = "/build"
    }

    Write-Output "----  BUILDING MSDF (C++)  ----"

    if (($buildmode -eq "debug") -or ($buildmode -eq "all"))
    {
        Write-Output "----     BUILDING DEBUG    ----"

        devenv .\msdfgen\Msdfgen.sln /project Msdfgen $rebuildSwitch "Debug Library"

        Write-Output "----     COPYING FILES     ----"

        $debugInput = ".\msdfgen\x64\Debug Library\";
        $debugOutput = ".\msdfgen-beef\dist\Debug-Win64\";

        if(!(Test-Path $debugOutput))
        {
            mkdir -Verbose $debugOutput
        }
    
        Copy-Item -Verbose -Path "$($debugInput)\msdfgen.lib" -Destination "$($debugOutput)msdfgen.lib"
        Copy-Item -Verbose -Path "$($debugInput)\msdfgen.pdb" -Destination "$($debugOutput)msdfgen.pdb"
    }
    
    if (($buildmode -eq "release") -or ($buildmode -eq "all"))
    {
        Write-Output "----    BUILDING RELEASE   ----"

        devenv .\msdfgen\Msdfgen.sln /project Msdfgen $rebuildSwitch "Release Library"

        Write-Output "----     COPYING FILES     ----"

        $releaseInput = ".\msdfgen\x64\Release Library\";
        $releaseOutput = ".\msdfgen-beef\dist\Release-Win64\";

        if(!(Test-Path $releaseOutput))
        {
            mkdir -Verbose $releaseOutput
        }

        Copy-Item -Verbose -Path "$($releaseInput)\msdfgen.lib" -Destination "$($releaseOutput)msdfgen.lib"
        Copy-Item -Verbose -Path "$($releaseInput)\msdfgen.pdb" -Destination "$($releaseOutput)msdfgen.pdb"
    }

    Write-Output "---- BUILD MSDF (C++) DONE ----"
}
