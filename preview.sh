#!/bin/sh

fgfs --fg-scenery=`pwd`/output --timeofday=noon --aircraft=ufo --altitude=500 --disable-real-weather-fetch --disable-clouds "$*"
