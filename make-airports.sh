#!/bin/sh

MIN_LAT=43
MAX_LAT=47
MIN_LON=-77
MAX_LON=-73

rm -rf work/AirportArea
rm -rf work/AirportObj
genapts850 --min-lat=$MIN_LAT --max-lat=$MAX_LAT --min-lon=$MIN_LON --max-lon=$MAX_LON --input=./data/airports/apt.dat --work=./work --dem-path=SRTM-3

