# Builds The msdfgen-c stub and copies it into the dist-directories

devenv ./build/msdfgen_c.sln /project msdfgen_c /rebuild DEBUG

Copy-Item -Verbose -Path "build\Debug\msdfgen_c.lib" -Destination "msdfgen-beef\dist\Debug-Win64\msdfgen_c.lib"
Copy-Item -Verbose -Path "build\Debug\msdfgen_c.pdb" -Destination "msdfgen-beef\dist\Debug-Win64\msdfgen_c.pdb"

devenv ./build/msdfgen_c.sln /project msdfgen_c /rebuild RELEASE

Copy-Item -Verbose -Path "build\Release\msdfgen_c.lib" -Destination "msdfgen-beef\dist\Release-Win64\msdfgen_c.lib"
