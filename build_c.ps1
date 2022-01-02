# Builds The msdfgen-c stub and copies it into the dist-directories

$buildtype = $args[0]
$buildmode = $args[1]

Write-Output "----       MSDF (C)       ----"

function RunMake
{
    Write-Output "----   Running CMake...   ----"

    if(!(Test-Path "build"))
    {
        mkdir -Verbose "build"
    }

    Set-Location "build"

    cmake ..

    Set-Location ..

    Write-Output "----     CMake done!      ----"
}

if (($buildtype -eq "make"))
{
    RunMake
}
elseif ((!$buildtype) -or (!$buildmode))
{
    Write-Output "No build options specified..."
    Write-Output "Usage: build_c.ps1 [make|build|rebuild] [debug|release|all]"
}
else
{
    if (!(Test-Path "build"))
    {
        RunMake
    }

    Write-Output "---- Building MSDF (C)... ----"

    $rebuildSwitch = ""

    if (($buildtype -eq "rebuild"))
    {
        $rebuildSwitch = "/rebuild"
    }
    elseif(($buildtype -eq "build"))
    {
        $rebuildSwitch = "/build"
    }

    if (($buildmode -eq "debug") -or ($buildmode -eq "all"))
    {
        devenv ./build/msdfgen_c.sln /project msdfgen_c $rebuildSwitch DEBUG
    
        Copy-Item -Verbose -Path "build\Debug\msdfgen_c.lib" -Destination "msdfgen-beef\dist\Debug-Win64\msdfgen_c.lib"
        Copy-Item -Verbose -Path "build\Debug\msdfgen_c.pdb" -Destination "msdfgen-beef\dist\Debug-Win64\msdfgen_c.pdb"
    }

    if (($buildmode -eq "release") -or ($buildmode -eq "all"))
    {
        devenv ./build/msdfgen_c.sln /project msdfgen_c $rebuildSwitch RELEASE
    
        Copy-Item -Verbose -Path "build\Release\msdfgen_c.lib" -Destination "msdfgen-beef\dist\Release-Win64\msdfgen_c.lib"
    }

    Write-Output "---- Build MSDF (C) DONE  ----"
}
