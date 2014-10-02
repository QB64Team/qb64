'Get Current Working Directory
clearid
id.n = "_CWD"
id.musthave = "$"
id.subfunc = 1
id.callname = "func__cwd"
id.ret = STRINGTYPE - ISPOINTER
id.Dependency = DEPENDENCY_USER_MODS
regid

clearid
id.n = "_KEYCLEAR"
id.subfunc = 2
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.callname = "sub__keyclear"
id.Dependency = DEPENDENCY_USER_MODS
regid
