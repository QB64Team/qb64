#ifndef __TEST_SUITE_H__
#define __TEST_SUITE_H__

#include <stdarg.h>
#include <stdlib.h>
#include <string.h>

typedef struct TestSuite TestSuite;

extern void (* g_unitTestFailureCallback)(const char * file, const char * function, int line, const char * format, ...) __attribute__((__noreturn__)) __attribute__((format(printf, 4, 5)));

struct TestSuite {
	char * description;
	unsigned int numberOfTestCases;
	void (** testCases)();
};

#define TestCase_assert(condition, ...) \
	if (!(condition)) { \
		(*g_unitTestFailureCallback)(__FILE__, __FUNCTION__, __LINE__, __VA_ARGS__); \
	}

#ifdef WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT
#endif
#define TEST_SUITE(name, ...) \
DLLEXPORT TestSuite * name##_suite() { \
	return testSuite(#name, __VA_ARGS__, NULL); \
}

static inline TestSuite * testSuite(const char * description, ...) __attribute__((sentinel));
static inline TestSuite * testSuite(const char * description, ...) {
	TestSuite * suite;
	va_list args;
	unsigned int testCaseIndex;
	
	suite = malloc(sizeof(TestSuite));
	
	va_start(args, description);
	for (suite->numberOfTestCases = 0; va_arg(args, void (*)()) != NULL; suite->numberOfTestCases++);
	va_end(args);
	
	suite->description = malloc(strlen(description) + 1);
	strcpy(suite->description, description);
	suite->testCases = malloc(sizeof(void (*)()) * suite->numberOfTestCases);
	va_start(args, description);
	for (testCaseIndex = 0; testCaseIndex < suite->numberOfTestCases; testCaseIndex++) {
		suite->testCases[testCaseIndex] = va_arg(args, void (*)());
	}
	va_end(args);
	
	return suite;
}

#endif
