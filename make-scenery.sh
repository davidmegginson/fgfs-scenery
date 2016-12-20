#!/bin/sh

MIN_LAT=44
MAX_LAT=46
MIN_LON=-77
MAX_LON=-75

INPUTS="AirportArea SRTM-3 AirportObj Landmass InlandWater Water WaterExtra Roads Railways Places Landuse TreeCover CropCover GrassCover BuiltUpCover"

echo Inputs: $INPUTS

rm -rf output/Terrain
rm -rf work/Shared
tg-construct --threads --priorities=./priorities.txt --work-dir=./work --output-dir=./output/Terrain --min-lon=$MIN_LON --max-lon=$MAX_LON --min-lat=$MIN_LAT --max-lat=$MAX_LAT $INPUTS
#tg-construct --threads --work-dir=./work --output-dir=./output/Terrain --tile-id=1712601 $INPUTS
