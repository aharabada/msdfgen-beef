# msdfgen-beef

## Setup:
Before you can get started you probably have to compile Skia and MSDFGen and the C-Wrapper.

1. Run `git submodule update --init` (Pulls the msdfgen)
2. Modify buildskia.ps1 as needed
3. Run `./buildskia.ps1` (Pulls and compiles skia)
4. Modify the msdfgen project as needed
5. Run `./build_msdfgen.ps1 build all` (Compiles msdfgen)
6. Run `./build_c.ps1 build all` (Compiles the c-wrapper)

## Prepare SKIA:
Depending on your system you might need to modify buildskia.ps1 in order to correctly compile it.
- In order to compile SKIA you need to have Visual Studio in your Path variables (specifically: Powershell has to find *devenv*). If you don't want to modify your path variables globally you can add it locally by modifying buildskia.ps1 (at the top of the file is an example)
- You must have the [ninja build system](https://ninja-build.org/). You can either install it globally or simply download it, put it anywhere you want and add it to the local Path variables by modifying buildskia.ps1
- If you have multiple versions of Visual Studio installed the build system might pick the wrong version of *msvc*. In that case you can modify buildskia.ps1. Set the `win_vc` argument for the generator-calls (the lines that start with `bin/gn gen`)
- If you want to use a different Runtime Library you can modify the `extra_cflags` for the generator-calls in buildskia.ps1 (By default we use "Multithreaded Static Debug" for Debug and "Multithreaded Static" for Release)

## Prepare MSDFGen:
You might have to edit the msdfgen-Project before building it.
- The Visual Studio Project is quite old, you might want to Upgrade it (`devenv /Upgrade .\msdfgen\Msdfgen.sln`)
- MSDFGen uses an older version of skia. Because of this you have to add the "skia"-Folder to the include directories in the project settings under "C/C++->General->Additional include directories"
- You might want to change the project settings "C/C++->General->Debug Information Format" to "Program Database (/Zi)" to prevent getting a warning when building the beef project
- You have to disable "Whole Program Optimization" in the project settings "Advanced->Whole Program Optimization"

## Prepare the Wrapper:
If you want to expose more functions simply add them to stub.h and stub.cpp (and the beef library of course) and rerun `./build_c.ps1 build all`