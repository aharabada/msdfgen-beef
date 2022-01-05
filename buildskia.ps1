# Add needed programs to the path variable
# For example add visual studio (needed vor devenv)
# $Env:Path += ";C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE"
# For example add ninja (which is in a subdirectory of the current directory)
# $Env:Path += ";$(Get-Item "./ninja").FullName"

$depot_tools_dir = "./msdfgen/depot_tools"
$skia_directory = "./msdfgen/skia"

if (!(Test-Path $depot_tools_dir))
{
    Write-Output "Installing depot-tools...`n"
    
    # install depot_tools
    git clone 'https://chromium.googlesource.com/chromium/tools/depot_tools.git' $depot_tools_dir
}
else
{
    Write-Output "depot-tools already there: Skipping installation!`n"
}

# add depot_tools to Path-Variable (only for this process)
$Env:Path += (";" + (Get-Item $depot_tools_dir).FullName)

$homeLocation = Get-Location

$gn_path = (Join-Path -Path $skia_directory -ChildPath "gn")
# If $gn_path doesn't exist we can assume that skia wasn't pulled yet
if (!(Test-Path $gn_path))
{
    Write-Output "`nRemoving old skia directory...`n"

    Remove-Item -Recurse -Force $skia_directory

    Write-Output "`nCloning skia...`n"

    # clone skia
    git clone https://skia.googlesource.com/skia.git $skia_directory

    Write-Output "`nSyncing skia...`n"
    Set-Location $skia_directory
    py tools/git-sync-deps
}
else
{
    Set-Location $skia_directory
}

# create the vs project for debug builds
Write-Output "`nGenerating Debug Project...`n"
# Note: if you need a different runtime library than "Multithreaded Static Debug" replace /MTd with the flag of your desired library
# Note: if you need a different version of msvc change win_vc in --args (e.g. win_vc=\"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\")
bin/gn gen win64/debug --args='is_official_build=true win_vc=\"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\" extra_cflags=[\"/MTd\"] skia_use_system_libpng=false skia_use_zlib=false skia_use_system_zlib=false skia_use_libjpeg_turbo_encode=false skia_use_libjpeg_turbo_decode=false skia_use_expat=false skia_use_libwebp_encode=false skia_use_libwebp_decode=false' --ide=vs

Write-Output "`nGenerating Release Project...`n"
bin/gn gen win64/release --args='is_official_build=true win_vc=\"C:\Program Files\Microsoft Visual Studio\2022\Community\VC\" extra_cflags=[\"/MT\"] skia_use_system_libpng=false skia_use_zlib=false skia_use_system_zlib=false skia_use_libjpeg_turbo_encode=false skia_use_libjpeg_turbo_decode=false skia_use_expat=false skia_use_libwebp_encode=false skia_use_libwebp_decode=false' --ide=vs

Write-Output "`nBuilding Debug Project...`n"
devenv win64/debug/all.sln /project skia /build GN

Write-Output "`nBuilding Release Project...`n"
devenv win64/release/all.sln /project skia /build GN

Write-Output "`nCopying libraries to output...`n"

# Copy Debug
$debugInput = "./win64/debug/";
$debugOutput = (Join-Path -Path $homeLocation -ChildPath "msdfgen-beef/dist/Debug-Win64/");

if(!(Test-Path $debugOutput))
{
    mkdir -Verbose $debugOutput
}

Copy-Item -Verbose -Path "${debugInput}/skia.lib" -Destination ("${debugOutput}/skia.lib")

# Copy Release
$releaseInput = "./win64/release/";
$releaseOutput = (Join-Path -Path $homeLocation -ChildPath "msdfgen-beef/dist/Release-Win64/");

if(!(Test-Path $releaseOutput))
{
    mkdir -Verbose $releaseOutput
}

Copy-Item -Verbose -Path "${releaseInput}/skia.lib" -Destination ("${releaseOutput}/skia.lib")

# return to working directory directory
Set-Location $homeLocation

Write-Output "`nSkia DONE`n"