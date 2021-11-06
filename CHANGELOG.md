# QB64 v2.0.x - What's new?

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
- Fixes `Const` parser accepting unsupported string functions and failing with some very specific const names.
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
- Fixes evaluation of valid var/flag names for `$Let`/`$If` - same rules for variable names now apply.
- Fixes incorrect parsing of `Type` blocks with multiple elements using the `AS type element-list` syntax.
- Fixes issue with `Put #` and variable-length strings in UDTs (`Binary` files).
- Fixes issue with recursive functions without parameters.

#### Fixed in 2.0.1
- Fix "Duplicate definition" error with Static arrays in Subs/Functions with active On Error trapping.
- Fix internal UDT arrays not resetting when a new file is loaded.
- Fix issue preventing `$Debug` from working in Windows versions prior to Windows 10.

#### Fixed in 2.0.2
- Fix issue with `LBound`/`UBound` calls in complex expressions.

### Windows
- Allows `$Console:Only` programs to return `_WindowHandle`.
- Saving a file to the root of a drive would display double backslashes in the Recent Files list.

### macOS
- Flushes the console output so `Print` can properly display text even while retaining the cursor.

#### Fixed in 2.0.2
- Fix issue preventing compilation in macOS versions prior to Catalina.

### Linux
- `xmessage` added to dependency list (setup script).
- Fixes `InKey$` acting too slow.
- Fixes compilation error with `Data` statements on gcc 11.
- Detects non-x86 based architectures.
- Flushes the console output so `Print` can properly display text even while retaining the cursor.
