# QB64 development build - Changelog
Upcoming version is currently identified as v2.1, but that number may change before release.

## New features
### All platforms
- Implement the `_Bin$` function as counterpart to `&B` prefixed number strings. Usage is analog to the legacy OCT$ and HEX$ functions.
- Save Watch Panel position and size.
- Add `$NOPREFIX` support for `$COLOR`.
- Allow changing color of menu panels and dialogs (Options->IDE Colors).
- Add support to different number formats in Watch Panel and Watch List dialog (dec/hex/oct/bin).

<!--- 
### Windows

### macOS

### Linux
--->

## Fixes
### All platforms
- Fix function `LOC` returning wrong values when used on physical files.
- Fix glitch in syntax highlighter mistaking variable names with scientific notation.
- Fix Variable List dialog's "Add All" button not properly considering the active filter.
- Fix wiki update feature.
- Fix issue with Sub/Function parameters in `Declare` blocks with `$NoPrefix`.
- Fix issue with Sub/Function parameters without types after `As`.
- Fix issue with capitalization of array names in `LBound/UBound` calls.
- Fix capitalization of 'To' in `Case` statements.
- Fix indentation issue in disabled precompiler blocks.
- Fix crash when a variable was deleted between `$Debug` sessions.
- Reenables selecting a line by clicking the line number bar when `$Debug` is not used and the `Auto-add $Debug metacommand` feature is disabled.

<!---
### Windows

### macOS
--->

### Linux
- Fix building static libraries when installation path contains spaces.