#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <setjmp.h>
#include <unistd.h>

#include "unittest/framework/TestSuite.h"

extern TestSuite ** getTestSuites();

void (* g_unitTestFailureCallback)(const char * file, const char * function, int line, const char * format, ...) __attribute__((__noreturn__)) __attribute__((format(printf, 4, 5)));

static int failures = 0;
static jmp_buf jmpEnv;

static int lengthOfSharedPrefix(const char * string1, const char * string2) {
	int charIndex;
	
	for (charIndex = 0; string1[charIndex] != '\x00' && string2[charIndex] != '\x00'; charIndex++) {
		if (string1[charIndex] != string2[charIndex]) break;
	}
	return charIndex;
}

static void assertFailureCallback(const char * file, const char * function, int line, const char * format, ...) __attribute__((__noreturn__)) __attribute__((format(printf, 4, 5)));
static void assertFailureCallback(const char * file, const char * function, int line, const char * format, ...) {
	va_list args;
	static char * sourceRoot = NULL;
	
	if (sourceRoot == NULL) {
		int charIndex;
		int length;
		
		length = strlen(__FILE__);
		sourceRoot = malloc(length + 1);
		strcpy(sourceRoot, __FILE__);
		for (charIndex = 0; charIndex < length; charIndex++) {
			if (!strcmp(sourceRoot + charIndex, "unittest/unittest_main.c")) {
				sourceRoot[charIndex] = '\x00';
				break;
			}
		}
	}
	
	file += lengthOfSharedPrefix(sourceRoot, file);
	printf("  FAILURE in %s (%s:%d):\n    ", function, file, line);
	va_start(args, format);
	vprintf(format, args);
	va_end(args);
	putchar('\n');
	
	failures++;
	longjmp(jmpEnv, 1);
}

int main(int argc, char ** argv) {
	TestSuite ** testSuites;
	unsigned int numberOfTestSuites;
	unsigned int testSuiteIndex, testCaseIndex;
	
	if (argc > 1) {
		chdir(argv[1]);
	}
	
	g_unitTestFailureCallback = assertFailureCallback;
	
	testSuites = getTestSuites();
	for (numberOfTestSuites = 0; testSuites[numberOfTestSuites] != NULL; numberOfTestSuites++);
	
	putchar('\n');
	for (testSuiteIndex = 0; testSuiteIndex < numberOfTestSuites; testSuiteIndex++) {
		printf("%s (%d/%d) running %d test%s...\n", testSuites[testSuiteIndex]->description, testSuiteIndex + 1, numberOfTestSuites, testSuites[testSuiteIndex]->numberOfTestCases, testSuites[testSuiteIndex]->numberOfTestCases == 1 ? "" : "s");
		for (testCaseIndex = 0; testCaseIndex < testSuites[testSuiteIndex]->numberOfTestCases; testCaseIndex++) {
			if (setjmp(jmpEnv) != 0) {
				continue;
			}
			testSuites[testSuiteIndex]->testCases[testCaseIndex]();
		}
	}
	printf("\nTests completed (%d failure%s)\n\n", failures, failures == 1 ? "" : "s");
	
	return failures ? EXIT_FAILURE : EXIT_SUCCESS;
}
