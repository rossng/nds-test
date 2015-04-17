//
// Created by Jeremy David on 17.04.15.
//

#include <nds.h>

#ifndef SHARED_DSUTILS_HPP
#define SHARED_DSUTILS_HPP

inline
int ds_float(int real, short frac)
{
    return ( (real << 8) | frac );
}

#endif //HELLO_WORLD_DSUTILS_HPP
