# QB64 development build - Changelog

## New features
### All platforms
- Implemented the `_Bin$` function as counterpart to `&B` prefixed number strings. Usage is analog to the legacy OCT$ and HEX$ functions.

<!--- 
### Windows

### macOS

### Linux
--->

## Fixes
### All platforms
- Fix "Duplicate definition" error with `Static` arrays in Subs/Functions with active `On Error` trapping.
- Fix internal UDT arrays not resetting when a new file is loaded.

<!---
### Windows

### macOS

### Linux

--->
