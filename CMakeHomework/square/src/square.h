#define _SQUARE_H_

#ifdef SQUARE_BUILD_SHARED
    #define SQUARE_API __declspec(dllimport)

#else
    #define SQUARE_API
#endif

