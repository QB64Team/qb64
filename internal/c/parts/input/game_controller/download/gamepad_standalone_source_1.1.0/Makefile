.PHONY: all
all: library unittest testharness test include

UNAME = ${shell uname}
ifeq (${UNAME},Linux)
HOST_PLATFORM = linux
else ifeq (${UNAME},Darwin)
HOST_PLATFORM = macosx
else
HOST_PLATFORM = windows
endif

TARGET_PLATFORMS_macosx = macosx
TARGET_PLATFORMS_linux = linux
TARGET_PLATFORMS_windows = windows

include version

PROJECT_NAME = gamepad

LIBRARY_TARGETS = library
EXECUTABLE_TARGETS = unittest
APPLICATION_TARGETS = testharness
TARGETS = ${LIBRARY_TARGETS} ${EXECUTABLE_TARGETS} ${APPLICATION_TARGETS}
CONFIGURATIONS = debug profile release
PLATFORMS = ${filter ${TARGET_PLATFORMS_${HOST_PLATFORM}},macosx linux windows}
ARCHS = ppc i386 i686 x86_64

TARGET_NAME_library = libstem_gamepad
TARGET_NAME_unittest = unittest
TARGET_NAME_testharness = GamepadTestHarness

#Per-target configurations
CONFIGURATIONS_library = debug profile release
CONFIGURATIONS_unittest = debug
CONFIGURATIONS_testharness = debug profile

#Per-target platforms
PLATFORMS_library = ${filter ${PLATFORMS},macosx linux windows}
PLATFORMS_unittest = ${filter ${PLATFORMS},macosx linux windows}
PLATFORMS_testharness = ${filter ${PLATFORMS},macosx linux windows}

#Per-target compile/link settings
CCFLAGS_unittest = -I test_source -DSUITE_FILE_LIST='${foreach file,${SOURCES_unittest_suites},"${basename ${notdir ${file}}}",} NULL'

#Per-configuration compile/link settings
CCFLAGS_debug = -g
CCFLAGS_profile = -g -O3
CCFLAGS_release = -O3

#Per-platform compile/link settings
CC_macosx_ppc = /usr/bin/gcc-4.2 -arch ppc
CC_macosx_i386 = /Developer/usr/bin/clang -arch i386
CC_macosx_x86_64 = /Developer/usr/bin/clang -arch x86_64
AR_macosx = /usr/bin/ar
RANLIB_macosx = /usr/bin/ranlib
SDKROOT_macosx = /Developer/SDKs/MacOSX10.5.sdk
ARCHS_macosx = ppc i386 x86_64
CCFLAGS_macosx = -isysroot ${SDKROOT_macosx} -mmacosx-version-min=10.5
LINKFLAGS_macosx = -isysroot ${SDKROOT_macosx} -mmacosx-version-min=10.5 -framework IOKit -framework CoreFoundation -framework OpenGL -framework GLUT

CC_linux_i686 = /usr/bin/gcc
AR_linux = /usr/bin/ar
RANLIB_linux = /usr/bin/ranlib
ARCHS_linux = i686
CCFLAGS_linux =
LINKFLAGS_linux = -lm -ldl -lglut -Wl,-E

CC_windows_i686 = \\MinGW\\bin\\gcc.exe
AR_windows = \\MinGW\\bin\\ar.exe
RANLIB_windows = \\MinGW\\bin\\ranlib.exe
ARCHS_windows = i686
CCFLAGS_windows = -DFREEGLUT_STATIC
LINKFLAGS_windows = -lfreeglut_static -lopengl32 -lglu32 -lwinmm -lgdi32 -mwindows -mconsole

#General compile/link settings
DEFINE_CCFLAGS = -DVERSION_MAJOR=${VERSION_MAJOR}u -DVERSION_MINOR=${VERSION_MINOR}u -DVERSION_TWEAK=${VERSION_TWEAK}u
WARNING_CCFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror
INCLUDE_CCFLAGS = -I source -I include
OTHER_CCFLAGS = -std=gnu99
CCFLAGS = ${DEFINE_CCFLAGS} ${WARNING_CCFLAGS} ${INCLUDE_CCFLAGS} ${OTHER_CCFLAGS}

FRAMEWORK_LINKFLAGS = 
LIBRARY_LINKFLAGS = 
OTHER_LINKFLAGS = 
LINKFLAGS = ${FRAMEWORK_LINKFLAGS} ${LIBRARY_LINKFLAGS} ${OTHER_LINKFLAGS}

#Per-target depencies

LIBRARY_DEPENDENCIES_unittest =
LIBRARY_DEPENDENCIES_testharness = utilities/libstem_utilities.a glutshell/libstemshell_glut.a

#Per-target source file lists

SOURCES_library = \
	source/gamepad/Gamepad_${HOST_PLATFORM}.c \
	source/utilities/EventDispatcher.c

SOURCES_unittest = \
	test_source/unittest/framework/unittest_main.c \
	test_source/unittest/framework/TestList.c \
	${SOURCES_unittest_suites}

SOURCES_unittest_suites = \
	test_source/unittest/suites/GamepadTest.c

SOURCES_testharness = \
	test_source/testharness/TestHarness_main.c

SOURCES = ${sort ${foreach target,${TARGETS},${SOURCES_${target}}}}

INCLUDES = \
	source/gamepad/Gamepad.h \
	source/utilities/EventDispatcher.h



define configuration_object_list_template #(target, configuration)
	${foreach platform,${PLATFORMS_${1}}, \
		${call platform_object_list_template,${1},${2},${platform}} \
	}
endef

define platform_object_list_template #(target, configuration, platform)
	${foreach arch,${ARCHS_${3}}, \
		${call arch_object_list_template,${1},${2},${3},${arch}} \
	}
endef

define arch_object_list_template #(target, configuration, platform, arch)
	${foreach source,${SOURCES_${1}}, \
		build/intermediate/${2}-${3}-${4}/${notdir ${basename ${source}}}.o \
	}
endef

#Produces OBJECTS_${target}_${configuration} variables for each permutation of target and configuration in that target
${foreach target,${TARGETS}, \
	${foreach configuration,${CONFIGURATIONS_${target}}, \
		${eval OBJECTS_${target}_${configuration} = ${call configuration_object_list_template,${target},${configuration}}} \
	} \
}



define compile_template #(target, configuration, platform, arch, source_file)
build/intermediate/${2}-${3}-${4}/${notdir ${basename ${5}}}.o: ${5}
	mkdir -p build/intermediate/${2}-${3}-${4}
	${CC_${3}_${4}} ${CCFLAGS} ${CCFLAGS_${1}} ${CCFLAGS_${2}} ${CCFLAGS_${3}} -c -o $$@ $$^
endef

#Produces object build targets for all source files in each configuration/platform/arch
${foreach target,${TARGETS}, \
	${foreach configuration,${CONFIGURATIONS}, \
		${foreach platform,${PLATFORMS_${target}}, \
			${foreach arch,${ARCHS_${platform}}, \
				${foreach source,${SOURCES_${target}}, \
					${eval ${call compile_template,${target},${configuration},${platform},${arch},${source}}} \
				} \
			} \
		} \
	} \
}



define library_template #(target, configuration, platform, arch, output_file)
build/intermediate/${2}-${3}-${4}/${5}: ${call arch_object_list_template,${1},${2},${3},${4}}
	${AR_${3}} rc $$@ $$^
	${RANLIB_${3}} $$@
endef

#Produces static library build targets for each arch/platform/target for library targets
${foreach target,${LIBRARY_TARGETS}, \
	${foreach configuration,${CONFIGURATIONS_${target}}, \
		${foreach platform,${PLATFORMS_${target}}, \
			${foreach arch,${ARCHS_${platform}}, \
				${eval ${call library_template,${target},${configuration},${platform},${arch},${TARGET_NAME_${target}}.a}} \
			} \
		} \
	} \
}



define executable_template #(target, configuration, platform, arch, output_file, dependent_libraries)
build/intermediate/${2}-${3}-${4}/${5}: ${call arch_object_list_template,${1},${2},${3},${4}} ${6}
	${CC_${3}_${4}} -o $$@ $$^ ${LINKFLAGS} ${LINKFLAGS_${3}}
endef

define library_dependency_template #(target, configuration, platform)
	build/library/debug-${3}/${TARGET_NAME_library}.a \
	${foreach library,${LIBRARY_DEPENDENCIES_${1}}, \
		lib/${dir ${library}}${configuration}-${platform}/${notdir ${library}} \
	}
endef

#Produces executable build targets for each arch/platform/target for executable and application targets
${foreach target,${EXECUTABLE_TARGETS} ${APPLICATION_TARGETS}, \
	${foreach configuration,${CONFIGURATIONS_${target}}, \
		${foreach platform,${PLATFORMS_${target}}, \
			${foreach arch,${ARCHS_${platform}}, \
				${eval ${call executable_template,${target},${configuration},${platform},${arch},${TARGET_NAME_${target}},${call library_dependency_template,${target},${configuration},${platform}}}} \
			} \
		} \
	} \
}



define thin_binary_list_template #(target_name, configuration, platform)
	${foreach arch,${ARCHS_${3}}, \
		build/intermediate/${2}-${3}-${arch}/${1} \
	}
endef

#Produces THIN_BINARIES_${target}_${configuration}_${platform} variables for each target/configuration/platform for library targets
${foreach target,${LIBRARY_TARGETS}, \
	${foreach configuration,${CONFIGURATIONS_${target}}, \
		${foreach platform,${PLATFORMS_${target}}, \
			${eval THIN_BINARIES_${target}_${configuration}_${platform} = ${call thin_binary_list_template,${TARGET_NAME_${target}}.a,${configuration},${platform}}} \
		} \
	} \
}

#Produces THIN_BINARIES_${target}_${configuration}_${platform} variables for each target/configuration/platform for executable targets
${foreach target,${EXECUTABLE_TARGETS}, \
	${foreach configuration,${CONFIGURATIONS_${target}}, \
		${foreach platform,${PLATFORMS_${target}}, \
			${eval THIN_BINARIES_${target}_${configuration}_${platform} = ${call thin_binary_list_template,${TARGET_NAME_${target}},${configuration},${platform}}} \
		} \
	} \
}

#Produces THIN_BINARIES_${target}_${configuration}_${platform} variables for each target/configuration/platform for application targets
${foreach target,${APPLICATION_TARGETS}, \
	${foreach configuration,${CONFIGURATIONS_${target}}, \
		${foreach platform,${PLATFORMS_${target}}, \
			${eval THIN_BINARIES_${target}_${configuration}_${platform} = ${call thin_binary_list_template,${TARGET_NAME_${target}},${configuration},${platform}}} \
		} \
	} \
}



define assemble_library_macosx #(target, configuration, platform)
build/${1}/${2}-${3}/${TARGET_NAME_${1}}.a: ${THIN_BINARIES_${1}_${2}_${3}}
	mkdir -p $${dir $$@}
	lipo -create -output $$@ $$^
endef

define assemble_library_linux #(target, configuration, platform)
build/${1}/${2}-${3}/${TARGET_NAME_${1}}.a: ${THIN_BINARIES_${1}_${2}_${3}}
	mkdir -p $${dir $$@}
	cp $$^ $$@
endef

define assemble_library_windows #(target, configuration, platform)
build/${1}/${2}-${3}/${TARGET_NAME_${1}}.a: ${THIN_BINARIES_${1}_${2}_${3}}
	mkdir -p $${dir $$@}
	cp $$^ $$@
endef

#Produces final library build targets
${foreach target,${LIBRARY_TARGETS}, \
	${foreach configuration,${CONFIGURATIONS_${target}}, \
		${foreach platform,${PLATFORMS_${target}}, \
			${eval ${call assemble_library_${HOST_PLATFORM},${target},${configuration},${platform}}} \
		} \
	} \
}

define assemble_executable_macosx #(target, configuration, platform)
build/${1}/${2}-${3}/${TARGET_NAME_${1}}: ${THIN_BINARIES_${1}_${2}_${3}}
	mkdir -p $${dir $$@}
	lipo -create -output $$@ $$^
endef

define assemble_executable_linux #(target, configuration, platform)
build/${1}/${2}-${3}/${TARGET_NAME_${1}}: ${THIN_BINARIES_${1}_${2}_${3}}
	mkdir -p $${dir $$@}
	cp $$^ $$@
endef

define assemble_executable_windows #(target, configuration, platform)
build/${1}/${2}-${3}/${TARGET_NAME_${1}}.exe: ${THIN_BINARIES_${1}_${2}_${3}}
	mkdir -p $${dir $$@}
	cp $$^ $$@
endef

#Produces final executable build targets
${foreach target,${EXECUTABLE_TARGETS}, \
	${foreach configuration,${CONFIGURATIONS_${target}}, \
		${foreach platform,${PLATFORMS_${target}}, \
			${eval ${call assemble_executable_${HOST_PLATFORM},${target},${configuration},${platform}}} \
		} \
	} \
}

PLIST_FILE_testharness_macosx = test_resources/Info_testharness_macosx.plist

define assemble_application_macosx #(target, configuration, platform)
build/${1}/${2}-${3}/${TARGET_NAME_${1}}.app/Contents/MacOS/${TARGET_NAME_${1}}: ${THIN_BINARIES_${1}_${2}_${3}}
	mkdir -p $${dir $$@}
	mkdir -p $${dir $$@}../Resources
	sed -e "s/\$$$${PRODUCT_NAME}/${TARGET_NAME_${1}}/g" \
	    -e "s/\$$$${VERSION}/${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_TWEAK}/g" \
	    -e "s/\$$$${COPYRIGHT_YEAR}/"`date +%Y`"/g" \
	    -e "s/\$$$${BUILD_NUMBER}/0/g" \
	    -e "s/\$$$${PLATFORM_CASED}/${PLIST_PLATFORM_CASED_${3}}/g" \
	    -e "s/\$$$${PLATFORM_LOWER}/${PLIST_PLATFORM_LOWER_${3}}/g" \
	    -e "s/\$$$${SDK}/${PLIST_SDK_NAME_${3}}/g" \
	    ${PLIST_FILE_${1}_${3}} > $${dir $$@}/../Info.plist
	echo "APPL????" > $${dir $$@}../PkgInfo
	lipo -create -output $$@ $$^
endef

define assemble_application_linux #(target, configuration, platform)
build/${1}/${2}-${3}/${TARGET_NAME_${1}}: ${THIN_BINARIES_${1}_${2}_${3}}
	mkdir -p $${dir $$@}
	cp $$^ $$@
endef

define assemble_application_windows #(target, configuration, platform)
build/${1}/${2}-${3}/${TARGET_NAME_${1}}.exe: ${THIN_BINARIES_${1}_${2}_${3}}
	mkdir -p $${dir $$@}
	cp $$^ $$@
endef

#Produces final application build targets
${foreach target,${APPLICATION_TARGETS}, \
	${foreach configuration,${CONFIGURATIONS_${target}}, \
		${foreach platform,${PLATFORMS_${target}}, \
			${eval ${call assemble_application_${HOST_PLATFORM},${target},${configuration},${platform}}} \
		} \
	} \
}

define library_target_template_macosx #(target)
.PHONY: ${1}
${1}: ${foreach configuration,${CONFIGURATIONS_${1}},${foreach platform,${PLATFORMS_${1}},build/${1}/${configuration}-${platform}/${TARGET_NAME_${1}}.a}}
endef

define library_target_template_linux #(target)
.PHONY: ${1}
${1}: ${foreach configuration,${CONFIGURATIONS_${1}},${foreach platform,${PLATFORMS_${1}},build/${1}/${configuration}-${platform}/${TARGET_NAME_${1}}.a}}
endef

define library_target_template_windows #(target)
.PHONY: ${1}
${1}: ${foreach configuration,${CONFIGURATIONS_${1}},${foreach platform,${PLATFORMS_${1}},build/${1}/${configuration}-${platform}/${TARGET_NAME_${1}}.a}}
endef

define executable_target_template_macosx #(target)
.PHONY: ${1}
${1}: ${foreach configuration,${CONFIGURATIONS_${1}},${foreach platform,${PLATFORMS_${1}},build/${1}/${configuration}-${platform}/${TARGET_NAME_${1}}}}
endef

define executable_target_template_linux #(target)
.PHONY: ${1}
${1}: ${foreach configuration,${CONFIGURATIONS_${1}},${foreach platform,${PLATFORMS_${1}},build/${1}/${configuration}-${platform}/${TARGET_NAME_${1}}}}
endef

define executable_target_template_windows #(target)
.PHONY: ${1}
${1}: ${foreach configuration,${CONFIGURATIONS_${1}},${foreach platform,${PLATFORMS_${1}},build/${1}/${configuration}-${platform}/${TARGET_NAME_${1}}.exe}}
endef

define application_target_template_macosx #(target)
.PHONY: ${1}
${1}: ${foreach configuration,${CONFIGURATIONS_${1}},${foreach platform,${PLATFORMS_${1}},build/${1}/${configuration}-${platform}/${TARGET_NAME_${1}}.app/Contents/MacOS/${TARGET_NAME_${1}}}}
endef

define application_target_template_linux #(target)
.PHONY: ${1}
${1}: ${foreach configuration,${CONFIGURATIONS_${1}},${foreach platform,${PLATFORMS_${1}},build/${1}/${configuration}-${platform}/${TARGET_NAME_${1}}}}
endef

define application_target_template_windows #(target)
.PHONY: ${1}
${1}: ${foreach configuration,${CONFIGURATIONS_${1}},${foreach platform,${PLATFORMS_${1}},build/${1}/${configuration}-${platform}/${TARGET_NAME_${1}}.exe}}
endef

${foreach target,${LIBRARY_TARGETS}, \
	${eval ${call library_target_template_${HOST_PLATFORM},${target}}} \
}

${foreach target,${EXECUTABLE_TARGETS}, \
	${eval ${call executable_target_template_${HOST_PLATFORM},${target}}} \
}

${foreach target,${APPLICATION_TARGETS}, \
	${eval ${call application_target_template_${HOST_PLATFORM},${target}}} \
}

.PHONY: test
test: unittest ${foreach platform,${PLATFORMS_unittest},run_unittests_${platform}}

.PHONY: run_unittests_macosx
run_unittests_macosx:
	./build/unittest/debug-macosx/unittest

.PHONY: run_unittests_linux
run_unittests_linux:
	./build/unittest/debug-linux/unittest

.PHONY: run_unittests_windows
run_unittests_windows:
	./build/unittest/debug-windows/unittest.exe

.PHONY: include
include: ${INCLUDES}
	mkdir -p build/include
	cp $^ build/include

.PHONY: clean
clean:
	rm -rf build
	rm -rf dist
	rm -rf dist_append

