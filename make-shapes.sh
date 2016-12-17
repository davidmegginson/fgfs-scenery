#!/bin/sh

MIN_LAT=45
MAX_LAT=46
MIN_LON=-76
MAX_LON=-75

#
# Basic landmass
#
rm -rf work/Landmass
ogr-decode --max-segment 500 --area-type Default --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landmass data/shapefiles/land-polygons-split-4326

#
# Water
#

rm -rf work/Water
ogr-decode --where "fclass<>'wetland'" --max-segment 500 --area-type Lake --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Water data/shapefiles/osm-water-CA-ON
ogr-decode --where "fclass<>'wetland'" --max-segment 500 --area-type Lake --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Water data/shapefiles/osm-water-CA-QB
ogr-decode --where "fclass='wetland'" --max-segment 500 --area-type Marsh --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Water data/shapefiles/osm-water-CA-ON
ogr-decode  --where "fclass='wetland'"--max-segment 500 --area-type Marsh --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Water data/shapefiles/osm-water-CA-QB

rm -rf work/WaterExtra
ogr-decode --where "NATURAL='water'" --max-segment 500 --area-type Lake --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/WaterExtra data/shapefiles/osm-natural-export
ogr-decode --max-segment 500 --area-type Lake --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/WaterExtra data/shapefiles/osm-waterways-export

#
# Roads
#
rm -rf work/Roads
ogr-decode --where "fclass='motorway'" --line-width 12 --texture-lines --max-segment 500 --area-type Road-Motorway --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-ON
ogr-decode --where "fclass='motorway'" --line-width 12 --texture-lines --max-segment 500 --area-type Road-Motorway --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-QB
ogr-decode --where "fclass='primary'" --line-width 12 --texture-lines --max-segment 500 --area-type Road-Primary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-ON
ogr-decode --where "fclass='primary'" --line-width 12 --texture-lines --max-segment 500 --area-type Road-Primary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-QB
ogr-decode --where "fclass='secondary'" --line-width 10 --texture-lines --max-segment 500 --area-type Road-Secondary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-ON
ogr-decode --where "fclass='secondary'" --line-width 10 --texture-lines --max-segment 500 --area-type Road-Secondary --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Roads data/shapefiles/osm-roads-CA-QB

#
# OSM landuse
#
rm -rf work/Landuse
ogr-decode --where "fclass='forest' or fclass='park'" --max-segment 500 --area-type DeciduousForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --where "fclass='forest' or fclass='park'" --max-segment 500 --area-type DeciduousForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --where "fclass='farm'" --max-segment 500 --area-type MixedCrop --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --where "fclass='farm'" --max-segment 500 --area-type MixedCrop --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --where "fclass='grass' or fclass='cemetary'" --max-segment 500 --area-type GrassCover --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --where "fclass='grass' or fclass='cemetary'" --max-segment 500 --area-type GrassCover --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --where "fclass='residential'" --max-segment 500 --area-type SubUrban --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --where "fclass='residential'" --max-segment 500 --area-type SubUrban --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --where "fclass='industrial'" --max-segment 500 --area-type Industrial --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --where "fclass='industrial'" --max-segment 500 --area-type Industrial --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --where "fclass='commercial' or fclass='retail'" --max-segment 500 --area-type Town --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-ON
ogr-decode --where "fclass='commercial' or fclass='retail'" --max-segment 500 --area-type Town --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-landuse-CA-QB
ogr-decode --max-segment 500 --area-type BuiltUpCover --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Landuse data/shapefiles/osm-builtup-gen


#
# vmap0 defaults
#

# trees
rm -f work/TreeCover
ogr-decode --where "VEG_DESCRI='Deciduous'" --max-segment 500 --area-type DeciduousForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/TreeCover data/shapefiles/vmap0-tree
ogr-decode --where "VEG_DESCRI='Mixed Trees'" --max-segment 500 --area-type MixedForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/TreeCover data/shapefiles/vmap0-tree
ogr-decode --where "VEG_DESCRI='Evergreen'" --max-segment 500 --area-type EvergreenForest --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/TreeCover data/shapefiles/vmap0-tree

# farmland
rm -f work/CropCover
ogr-decode --max-segment 500 --area-type MixedCrop --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/CropCover data/shapefiles/vmap0-cropland

# grassland
rm -f work/GrassCover
ogr-decode --max-segment 500 --area-type Grassland --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/GrassCover data/shapefiles/vmap0-grassland

# built-up cover
#rm -f work/BuiltupCover
#ogr-decode --max-segment 500 --area-type BuiltUpCover --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/BuiltUpCover data/shapefiles/vmap0-builtup

