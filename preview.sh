#!/bin/sh

fgfs --fg-scenery=`pwd`/output --timeofday=noon --aircraft=ufo --altitude=2000 --disable-real-weather-fetch --disable-clouds "$*"
