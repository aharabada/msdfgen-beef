msdfgen-beef

Setup:
1. Run `git submodule update --init`
2. Run `./build_and_copy.ps1 build all`
3. Run `./build_c.ps1 build all`

Note when building msdfgen:
You might want to change the project settings "C/C++->General->Debug Information Format" to "Program Database (/Zi)" to prevent getting a warning when building the beef project