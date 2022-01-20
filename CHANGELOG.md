# QB64 development build - Changelog

## New features
### All platforms
- Implement the `_Bin$` function as counterpart to `&B` prefixed number strings. Usage is analog to the legacy OCT$ and HEX$ functions.
- Save Watch Panel position and size.
- Add `$NOPREFIX` support for `$COLOR`.
- Fix glitch in syntax highlighter mistaking variable names with scientific notation.
- Fix Variable List dialog's "Add All" button not properly considering the active filter.
- Fix wiki update feature.

<!--- 
### Windows

### macOS

### Linux
--->

## Fixes
### All platforms
- Fix function `LOC` returning wrong values when used on physical files.

<!---
### Windows

### macOS

### Linux

--->
