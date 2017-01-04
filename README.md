# FlightGear scenery

Scripts for creating FlightGear scenery using mainly OpenStreetMap and SRTM-3 data (with vmap0 as background).

## Scripts

These scripts are not yet documented or parameterised for general use; you'll have to look at the scripts and change areas covered, etc.

* make-dem.sh - Chunk up the DEM data (source data should be in data/SRTM-3/ in *.hgt files).
* merge-airports.sh - merge custom airports from the airports/ directory with the main file (should be in data/airports/default-apt.dat -- not included in repo).
* make-airports.sh - Generate global airport files (from data/airports/apt.dat).
* make-shapes.sh - Generate per-tile shapes from OSM shapefiles (original data in subdirectories under data/shapefiles).
* make-scenery.sh - Generate the actual scenery.

## Directories

* data/ - input data files
* work/ - working directory for TerraGear
* output/ - output scenery directory
* models/ - Blender 3D models and *.ac exports
* airports/ - custom airport layouts in X-Plane format.

## Input shapefiles

The following shapefile directories are expected:

* data/shapefiles/osm-highway-line/
* data/shapefiles/osm-landmass-area/
* data/shapefiles/osm-landuse-area/
* data/shapefiles/osm-natural-area/
* data/shapefiles/osm-place-area/
* data/shapefiles/osm-place-point/
* data/shapefiles/osm-railway-line/
* data/shapefiles/osm-waterway-area/
* data/shapefiles/osm-waterway-line/
* data/shapefiles/vmap0-builtup/
* data/shapefiles/vmap0-cropland/
* data/shapefiles/vmap0-grassland/
* data/shapefiles/vmap0-tree/
