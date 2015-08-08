clearid
id.n = "_D2R"
id.subfunc =  1
id.callname = "func_deg2rad"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_D2G"
id.subfunc =  1
id.callname = "func_deg2grad"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_R2D"
id.subfunc =  1
id.callname = "func_rad2deg"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_R2G"
id.subfunc =  1
id.callname = "func_rad2grad"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_G2D"
id.subfunc =  1
id.callname = "func_grad2deg"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_G2R"
id.subfunc =  1
id.callname = "func_grad2rad"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid   'Clear the old id info so we set the slate for a new one
id.n = "_ATAN2" 'The name of our new one
id.subfunc = 1 'And this is a function
id.callname = "atan2" 'The C name of the function
id.args = 2 'It takes 2 parameters to work
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) 'These simply add up to represent the 2 patameters from what I can tell
id.ret = FLOATTYPE - ISPOINTER 'we want it to return to us a nice _FLOAT value
regid 'and we're finished with ID registration

clearid   'Clear the old id info so we set the slate for a new one
id.n = "_HYPOT" 'The name of our new one
id.subfunc = 1 'And this is a function
id.callname = "hypot" 'The C name of the function
id.args = 2 'It takes 2 parameters to work
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) 'These simply add up to represent the 2 patameters from what I can tell
id.ret = FLOATTYPE - ISPOINTER 'we want it to return to us a nice _FLOAT value
regid 'and we're finished with ID registration

clearid
id.n = "_ASIN"
id.subfunc =  1
id.callname = "asin"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ACOS"
id.subfunc =  1
id.callname = "acos"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_SINH"
id.subfunc =  1
id.callname = "sinh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_COSH"
id.subfunc =  1
id.callname = "cosh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_TANH"
id.subfunc =  1
id.callname = "tanh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ASINH"
id.subfunc =  1
id.callname = "asinh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ACOSH"
id.subfunc =  1
id.callname = "acosh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ATANH"
id.subfunc =  1
id.callname = "atanh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_CEIL"
id.subfunc =  1
id.callname = "ceil"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_PI"
id.subfunc = 1
id.callname = "func_pi"
id.args = 1
id.arg = MKL$(DOUBLETYPE - ISPOINTER)
id.ret = DOUBLETYPE - ISPOINTER
id.specialformat = "[?]"
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_DESKTOPHEIGHT"
id.subfunc = 1
id.callname = "func_screenheight"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_DESKTOPWIDTH"
id.subfunc = 1
id.callname = "func_screenwidth"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_SCREENICON"     'name change to from _ICONIFYWINDOW to _SCREENICON to match the screenshow and screenhide
id.subfunc = 2
id.callname = "sub_screenicon"
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_SCREENEXISTS"
id.subfunc = 1
id.callname = "func_windowexists"
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_CONTROLCHR"
id.subfunc = 1
id.callname = "func__controlchr"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_STRICMP"
id.subfunc = 1
id.callname = "func__str_nc_compare"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_STRCMP"
id.subfunc = 1
id.callname = "func__str_compare"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_ARCSEC"
id.subfunc =  1
id.callname = "func_arcsec"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_ARCCSC"
id.subfunc =  1
id.callname = "func_arccsc"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_ARCCOT"
id.subfunc =  1
id.callname = "func_arccot"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_SECH"
id.subfunc =  1
id.callname = "func_sech"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_CSCH"
id.subfunc =  1
id.callname = "func_csch"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_COTH"
id.subfunc =  1
id.callname = "func_coth"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_SEC"
id.subfunc =  1
id.callname = "func_sec"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_CSC"
id.subfunc =  1
id.callname = "func_csc"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_COT"
id.subfunc =  1
id.callname = "func_cot"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

