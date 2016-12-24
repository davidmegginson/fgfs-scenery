#!/bin/sh

rm -f data/airports/apt.dat

for file in airports/*.apt.dat; do
    echo Merging $file
    cat $file | grep -v '^1000' | grep -v '^99' >> data/airports/apt.dat
done
echo 99 >> data/airports/apt.dat

exit
