#!/usr/bin/bash
#
# Fetches last 24 hours of data from WWLLN Volcanic Lightning monitor
# 
# R.C. Stewart, 2023-08-11
#

cd /home/seisan/tmp--DONT_USE/wwlln

wget -O 00000000-last24hours.kml https://wwlln.net/USGS/Global/1600-05-.kml

mv *.kml /mnt/mvofls2/Seismic_Data/monitoring_data/other/wwlln/
