#!/bin/sh

MIN_LAT=44
MAX_LAT=46
MIN_LON=-77
MAX_LON=-75


decode_shape()
{
    echo Decoding: $@
    
    INPUT_DIR=${1}
    OUTPUT_DIR=${2}
    AREA_TYPE=${3}

    QUERY=''
    if [ -n "$4" ]; then
        QUERY="--where \"${4}\""
    fi

    LINE_WIDTH=''
    if [ -n "$5" ]; then
        LINE_WIDTH="--line-width \"${5}\""
    fi

    POINT_WIDTH=''
    if [ -n "$6" ]; then
        POINT_WIDTH="--point-width \"${6}\""
    fi

    ogr-decode --all-threads --max-segment 500 $POINT_WIDTH $LINE_WIDTH --area-type ${AREA_TYPE} --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/${OUTPUT_DIR} data/shapefiles/${INPUT_DIR}
}


rm -rf work/landmass
decode_shape osm-landmass-area landmass Default

rm -rf work/highway
decode_shape osm-highway-line highway Road-Motorway "highway='motorway'" 12
decode_shape osm-highway-line highway Road-Trunk "highway='trunk'" 12
decode_shape osm-highway-line highway Road-Primary "highway='primary'" 12
decode_shape osm-highway-line highway Road-Secondary "highway='secondary'" 10
decode_shape osm-highway-line highway Road-Tertiary "highway='tertiary'" 8
decode_shape osm-highway-line highway Road-Service "highway in ('motorway_link', 'trunk_link', 'primary_link', 'secondary_link', 'tertiary_link')" 8

rm -rf work/railway
decode_shape osm-railway-line railway Road-Motorway "railway in ('rail', 'light_rail', 'preserved')" 3

rm -rf work/wetland
decode_shape osm-natural-area wetland Marsh "natural='wetland'"

rm -rf work/water-area
decode_shape osm-natural-area water-area Lake "natural='water'"
decode_shape osm-waterway-area water-area Lake "waterway='riverbank'"
decode_shape osm-landuse-area water-area Lake "landuse in ('reservoir', 'water')"

rm -rf work/water-line
decode_shape osm-waterway-line water-line River "waterway='river'" 50
decode_shape osm-waterway-line water-line Stream "waterway='stream'" 25
decode_shape osm-waterway-line water-line Canal "waterway='canal'" 10

rm -rf work/quarry
decode_shape osm-landuse-area quarry OpenMining "landuse='quarry'"

rm -rf work/greenspace
decode_shape osm-landuse-area greenspace Cemetery "landuse='cemetery'"
decode_shape osm-landuse-area greenspace Grassland "landuse in ('recreation', 'recreation_ground')"

rm -rf work/builtup-area
decode_shape osm-landuse-area builtup-area Urban "landuse in ('commercial', 'industrial', 'retail')"
decode_shape osm-landuse-area builtup-area SubUrban "landuse in ('residential', 'allotments')"
decode_shape osm-place-area builtup-area Town "landuse in ('town', 'village', 'hamlet')"

rm -rf work/nature
decode_shape osm-landuse-area nature Sand "landuse='sand'"
decode_shape osm-landuse-area nature MixedForest "landuse in ('forest', 'wood')"
decode_shape osm-natural-area nature MixedForest "natural='wood'"
decode_shape osm-natural-area nature Scrub "natural='scrub'"
decode_shape osm-landuse-area nature MixedCrop "landuse in ('farm', 'farmland', 'farmyard', 'agriculture', 'vineyard')"
decode_shape osm-landuse-area nature Grassland "landuse in ('meadow', 'grass', 'airport')"
decode_shape osm-natural-area nature Grassland "landuse='grassland'"

rm -rf work/builtup-point
decode_shape osm-place-point builtup-point Town "place='town'" '' 750
decode_shape osm-place-point builtup-point Town "place='village'" '' 500
decode_shape osm-place-point builtup-point Town "place='hamlet'" '' 250

rm -rf  work/vmap0-veg
decode_shape vmap0-tree vmap0-veg DeciduousForest "VEG_DESCRI='Deciduous'"
decode_shape vmap0-tree vmap0-veg EvergreenForest "VEG_DESCRI='Evergreen'"
decode_shape vmap0-tree vmap0-veg MixedForest "VEG_DESCRI='Mixed Trees'"
decode_shape vmap0-cropland vmap0-veg MixedCrop
decode_shape vmap0-grassland vmap0-veg GrassCover

rm -rf work/vmap0-builtup
decode_shape vmap0-builtup vmap0-builtup BuiltUpCover

exit

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
# OSM point places
#
rm -rf work/Places
ogr-decode --all-threads --where "fclass='village'" --point-width 500 --max-segment 500 --area-type Town --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Places data/shapefiles/osm-places-CA-ON
ogr-decode --all-threads --where "fclass='village'" --point-width 500 --max-segment 500 --area-type Town --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Places data/shapefiles/osm-places-CA-QB
ogr-decode --all-threads --where "fclass='hamlet'" --point-width 250 --max-segment 500 --area-type Town --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Places data/shapefiles/osm-places-CA-ON
ogr-decode --all-threads --where "fclass='hamlet'" --point-width 250 --max-segment 500 --area-type Town --spat $MIN_LON $MIN_LAT $MAX_LON $MAX_LAT work/Places data/shapefiles/osm-places-CA-QB

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

