#ifndef CONFIG_H
#define CONFIG_H

#define OUTSIDE_SPEEX         1
#define OPUSTOOLS             1

#define inline __inline
#define alloca _alloca
#define getpid _getpid
#define USE_ALLOCA            1
#define FLOATING_POINT        1
#define SPX_RESAMPLE_EXPORT
#define __SSE__

#define RANDOM_PREFIX foo

#define PACKAGE_NAME "opus-tools"
#include "version.h"


#endif /* CONFIG_H */
