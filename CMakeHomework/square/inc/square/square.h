#ifndef _SQUARE_H_
#define _SQUARE_H_

#ifdef SQUARE_BUILD_SHARED
    #define SQUARE_API __declspec(dllimport)

#else
    #define SQUARE_API
#endif

int SQUARE_API Square(int x);

#endif
