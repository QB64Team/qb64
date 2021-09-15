# QB64 development build - Changelog

## New features
### All platforms
- New `$Debug` metacommand, with added breakpoint/step abilities and real-time variable watching to the IDE.
- Quick reference for commands is now shown in the status bar when syntax errors are detected.
- `_Source` is now also set to `_Console` when `$Console:Only` is used.
- Allows `Ctrl+\` to be used as a shortcut to repeat search (legacy QBasic shortcut).
- Functions `_MK$` and `_CV` can now deal with `_OFFSET` values.
- New "View on Wiki" button on help panel (launches equivalent wiki page using the default browser).
- New `_EnvironCount` function to show how many environment variables are found.
- Color schemes can now be set/saved individually for each running instance of the IDE.

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
- Fixes `Const` parser accepting unsupported string functions.
- Explicitly sets x87 fpu to extended precision mode.
- Removes 255-character limit for `Input/Line Input` with strings.
- Fixes `Data` commands failing to compile in some circumstances.
- `$NoPrefix`, `Option _Explicit` and `Option _ExplicitArray` can now be placed anywhere in a program, no longer having to be the first statement.
- Fixes `MEM` reverting to `_MEM` as a sub parameter in `$NoPrefix` mode.
- Fixes case adjustment of array names in `UBound`/`LBound` calls.
- Prevents users from creating self-referencing `Type` blocks.
- Fixes issue that prevented loading file names beginning with numbers.
- Fixes file open/save dialogs issue with path navigation.
- Complete rewrite of the internals for `Environ$()`.

### Windows
- Allows `$Console:Only` programs to return `_WindowHandle`.
- Saving a file to the root of a drive would display double backslashes in the Recent Files list.

<!---
### macOS
--->

### Linux
- `xmessage` added to dependency list (setup script).
- Fixes `InKey$` acting too slow.
- Fixes compilation error with DATA statements on gcc 11.
- Detects non-x86 based architectures.
<!---
- Patches condition that would leave zombie processes behind when using `Shell _DontWait`.
--->
