# QB64 development build - Changelog

## New features
### All platforms
- `_Source` is now also set to `_Console` when `$Console:Only` is used.
- Quick reference for commands is now shown in the status bar when syntax errors are detected.
- New `$Debug` metacommand, with added breakpoint/step abilities to the IDE.

### Windows
- Automatically embeds a manifest file when compiling an exe with `$VersionInfo`, so that Common Controls v6.0 gets linked at runtime.
- Adds the %TEMP%, Program Files and Program Files (x86) directories to `_Dir$()` folder specifications.

<!--- 
### macOS

### Linux
--->

## Fixes
### All platforms
- Improved wiki parser.
- Contextual menu would crash when right-clicking a series of high-ascii characters.
- Fixes an issue with passing an array as a Sub/Function argument (missing parenthesis now properly detected).
- Fixes `Clear` making `$Console` mode invalid.
- Fixes a syntax highlighter issue regarding scientific notation.
- Fixes an issue in Windows Vista and up with incorrect resolution returned on a scaled desktop.
- Fixes `Const` parser (no string functions allowed).
- Explicitly sets x87 fpu to extended precision mode.
- Removes 255 character limit for `Input/Line Input` with strings.
- Fixes `Data` commands failing to compile in some circumstances.
- `$NoPrefix`, `Option _Explicit` and `Option _ExplicitArray` can now be placed anywhere in a program, no longer having to be the first statement.

### Windows
- Allows $CONSOLE:ONLY programs to return `_WindowHandle`.
- Saving a file to the root of a drive would display double backslashes in the Recent Files list.

<!---
### macOS
--->

### Linux
- `xmessage` added to dependency list (setup script).
- Fixes `InKey$` acting too slow.
<!---
- Patches condition that would leave zombie processes behind when using `Shell _DontWait`.
--->