#!/bin/sh

MIN_LAT=44
MAX_LAT=46
MIN_LON=-77
MAX_LON=-75

rm -rf work/AirportArea
rm -rf work/AirportObj
genapts850 --min-lat=$MIN_LAT --max-lat=$MAX_LAT --min-lon=$MIN_LON --max-lon=$MAX_LON --input=./data/airports/apt.dat --work=./work --dem-path=SRTM-3

