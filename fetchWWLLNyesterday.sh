#!/usr/bin/bash
#
# Fetches yesterdays data from WWLLN Volcanic Lightning monitor
# 
# R.C. Stewart, 2023-08-11
#

cd /home/seisan/tmp--DONT_USE/wwlln

yesterday="$(date -d yesterday '+%Y%m%d')"

wget -O $yesterday.kml https://wwlln.net/USGS/Global/archive/$yesterday/1600-05-.kml

mv *.kml /mnt/mvofls2/Seismic_Data/monitoring_data/other/wwlln/
