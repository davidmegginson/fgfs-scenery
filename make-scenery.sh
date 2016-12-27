#!/bin/sh

MIN_LAT=43
MAX_LAT=47
MIN_LON=-77
MAX_LON=-73

INPUTS="AirportArea SRTM-3 AirportObj landmass highway railway wetland water-area water-line quarry greenspace builtup-area nature builtup-point vmap0-veg vmap0-builtup"

echo Inputs: $INPUTS

rm -rf output/Terrain
rm -rf work/Shared
tg-construct --threads --priorities=./priorities.txt --work-dir=./work --output-dir=./output/Terrain --min-lon=$MIN_LON --max-lon=$MAX_LON --min-lat=$MIN_LAT --max-lat=$MAX_LAT $INPUTS
#tg-construct --threads --priorities=./priorities.txt --work-dir=./work --output-dir=./output/Terrain --tile-id=1729002 $INPUTS
