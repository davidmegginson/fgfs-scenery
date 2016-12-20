#!/bin/sh

MIN_LAT=44
MAX_LAT=46
MIN_LON=-77
MAX_LON=-75

#
# Basic landmass
#
rm -rf work/Landmass
ogr-decode --all-threads --max-segment 500 --area-type Default --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landmass data/shapefiles/land-polygons-split-4326

#
# Water
#

rm -rf work/Water
ogr-decode --all-threads --where "fclass<>'wetland' and fclass<>'drain'" --max-segment 500 --line-width 50 --area-type Lake --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Water data/shapefiles/osm-water-CA-ON
ogr-decode --all-threads --where "fclass<>'wetland' and fclass<>'drain'" --max-segment 500 --line-width 50 --area-type Lake --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Water data/shapefiles/osm-water-CA-QB
ogr-decode --all-threads --where "fclass='wetland'" --max-segment 500 --area-type Marsh --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Water data/shapefiles/osm-water-CA-ON
ogr-decode --all-threads --where "fclass='wetland'" --max-segment 500 --area-type Marsh --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Water data/shapefiles/osm-water-CA-QB

rm -rf work/WaterExtra
ogr-decode --all-threads --where "NATURAL='water'" --max-segment 500 --area-type Lake --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/WaterExtra data/shapefiles/osm-natural-export
ogr-decode --all-threads --max-segment 500 --area-type Lake --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/WaterExtra data/shapefiles/osm-waterways-export

#
# Roads
#
rm -rf work/Roads
ogr-decode --all-threads --where "fclass='motorway'" --line-width 12 --texture-lines --max-segment 500 --area-type Road-Motorway --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-ON
ogr-decode --all-threads --where "fclass='motorway'" --line-width 12 --texture-lines --max-segment 500 --area-type Road-Motorway --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-QB
ogr-decode --all-threads --where "fclass='primary'" --line-width 12 --texture-lines --max-segment 500 --area-type Road-Primary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-ON
ogr-decode --all-threads --where "fclass='primary'" --line-width 12 --texture-lines --max-segment 500 --area-type Road-Primary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-QB
ogr-decode --all-threads --where "fclass='secondary'" --line-width 10 --texture-lines --max-segment 500 --area-type Road-Secondary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-ON
ogr-decode --all-threads --where "fclass='secondary'" --line-width 10 --texture-lines --max-segment 500 --area-type Road-Secondary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-QB
ogr-decode --all-threads --where "fclass='tertiary'" --line-width 8 --texture-lines --max-segment 500 --area-type Road-Tertiary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-ON
ogr-decode --all-threads --where "fclass='tertiary'" --line-width 8 --texture-lines --max-segment 500 --area-type Road-Tertiary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-QB

#
# Railroads
#
rm -rf work/Railroads
ogr-decode --all-threads --where "fclass='rail'" --line-width 3 --texture-lines --max-segment 500 --area-type Railroad --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Railways data/shapefiles/osm-railways-CA-ON
ogr-decode --all-threads --where "fclass='rail'" --line-width 3 --texture-lines --max-segment 500 --area-type Railroad --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Railways data/shapefiles/osm-railways-CA-QB

#
# OSM landuse
#
rm -rf work/Landuse
ogr-decode --all-threads --where "fclass='forest'" --max-segment 500 --area-type MixedForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --all-threads --where "fclass='forest'" --max-segment 500 --area-type MixedForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --all-threads --where "fclass='farm'" --max-segment 500 --area-type MixedCrop --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --all-threads --where "fclass='farm'" --max-segment 500 --area-type MixedCrop --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --all-threads --where "fclass='park' or fclass='grass' or fclass='cemetery'" --max-segment 500 --area-type Grassland --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --all-threads --where "fclass='park' or fclass='grass' or fclass='cemetery'" --max-segment 500 --area-type Grassland --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --all-threads --where "fclass='residential'" --max-segment 500 --area-type SubUrban --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --all-threads --where "fclass='residential'" --max-segment 500 --area-type SubUrban --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --all-threads --where "fclass='industrial'" --max-segment 500 --area-type Industrial --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --all-threads --where "fclass='industrial'" --max-segment 500 --area-type Industrial --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --all-threads --where "fclass='commercial' or fclass='retail'" --max-segment 500 --area-type Town --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --all-threads --where "fclass='commercial' or fclass='retail'" --max-segment 500 --area-type Town --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --all-threads --max-segment 500 --area-type BuiltUpCover --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-builtup-gen


#
# vmap0 defaults
#

# small settlements

rm -rf work/Settlements
ogr-decode --all-threads --where "F_CODE_DES='Settlement'" --max-segment 500 --point-width 500 --area-type BuiltUpCover --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Settlements data/shapefiles/vmap0-settlements


# trees
rm -rf work/TreeCover
ogr-decode --all-threads --where "VEG_DESCRI='Deciduous'" --max-segment 500 --area-type DeciduousForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/TreeCover data/shapefiles/vmap0-tree
ogr-decode --all-threads --where "VEG_DESCRI='Mixed Trees'" --max-segment 500 --area-type MixedForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/TreeCover data/shapefiles/vmap0-tree
ogr-decode --all-threads --where "VEG_DESCRI='Evergreen'" --max-segment 500 --area-type EvergreenForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/TreeCover data/shapefiles/vmap0-tree

# farmland
rm -rf work/CropCover
ogr-decode --all-threads --max-segment 500 --area-type MixedCrop --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/CropCover data/shapefiles/vmap0-cropland

# grassland
rm -rf work/GrassCover
ogr-decode --all-threads --max-segment 500 --area-type Grassland --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/GrassCover data/shapefiles/vmap0-grassland

# built-up cover
#rm -rf work/BuiltupCover
#ogr-decode --all-threads --max-segment 500 --area-type BuiltUpCover --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/BuiltUpCover data/shapefiles/vmap0-builtup

