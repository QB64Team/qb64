#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>

#if defined(WIN32)
#include <windows.h>
#else
#include <dlfcn.h>
#endif

#include "unittest/framework/TestSuite.h"

TestSuite ** getTestSuites() {
	static char * testFileNames[] = {SUITE_FILE_LIST};
	static TestSuite * testSuites[sizeof(testFileNames) / sizeof(char *)];
	char suiteFunctionName[256];
	unsigned int suiteIndex;
	struct TestSuite * (* suiteFunction)();
#if defined(WIN32)
	HMODULE moduleHandle;
	
	moduleHandle = GetModuleHandle(NULL);
#endif
	
	for (suiteIndex = 0; suiteIndex < sizeof(testFileNames) / sizeof(char *) - 1; suiteIndex++) {
		snprintf(suiteFunctionName, 256, "%s_suite", testFileNames[suiteIndex]);
#if defined(WIN32)
		suiteFunction = (struct TestSuite * (*)()) GetProcAddress(moduleHandle, suiteFunctionName);
#else
		suiteFunction = (struct TestSuite * (*)()) dlsym(RTLD_DEFAULT, suiteFunctionName);
#endif
		if (suiteFunction == NULL) {
			fprintf(stderr, "Couldn't load test suite %s (no symbol named %s found)\n", testFileNames[suiteIndex], suiteFunctionName);
			abort();
		}
		testSuites[suiteIndex] = suiteFunction();
	}
	testSuites[suiteIndex] = NULL;
	
	return testSuites;
}
