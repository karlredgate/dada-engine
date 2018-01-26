
#include <stdint.h>
#include <stdio.h>
#include <sys/time.h>

static uint64_t v = 4101842887655102017LL;

static uint64_t
now() {
    struct timeval now;
    gettimeofday( &now, NULL );
    return now.tv_usec;
}

void
seed_ranq1( uint64_t seed ) {
    if ( seed == 0 ) seed = now();
    v = 4101842887655102017LL ^ seed;
}

uint64_t
ranq1() {
    v ^= v >>21;
    v ^= v << 35;
    v ^= v >> 4;
    return v * 2685821657736338717LL;
}

/* vim: set autoindent expandtab sw=4 : */
