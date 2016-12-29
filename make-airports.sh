#!/bin/sh

MIN_LAT=40
MAX_LAT=50
MIN_LON=-80
MAX_LON=-70

rm -rf work/AirportArea
rm -rf work/AirportObj
genapts850 --min-lat=$MIN_LAT --max-lat=$MAX_LAT --min-lon=$MIN_LON --max-lon=$MAX_LON --input=./data/airports/apt.dat --work=./work --dem-path=SRTM-3

