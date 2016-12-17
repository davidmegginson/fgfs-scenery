#!/bin/sh

rm -rf work/SRTM-3
gdalchop work/SRTM-3 data/SRTM-3/*.hgt
terrafit work/STRM-3

