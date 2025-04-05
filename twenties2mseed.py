#!/usr/bin/env python
# twenties2mseed.py
#
# Reads all seisan files in current directory and saves as 24-hour singlechannel miniseed files.
#
# R.C. Stewart, 2023-05-03
#
import os
import sys
import glob
import obspy
from obspy import read
import numpy as np

def main():

    dirMseedOut = '/mnt/mvohvs3/MVOSeisD6/mseed/MV-fromTwenties'
    #dirMseedOut = '.'
    filesMseed = glob.glob('./*.msd')

    dates = []

    for file in filesMseed:
        dates.append(file[2:12])

    dates = list( set( dates ) )

    for date in dates:

        print( date )
        st = read( ''.join([date, '*']) )
        st.merge(method=1)
        #st.merge(method=0)

        for tr in st:

            if isinstance(tr.data, np.ma.masked_array):
                tr.data = tr.data.filled()

            dataDay = tr.stats.starttime
            fileMseedOut =  dataDay.strftime("%Y.%j")
            fileMseedOut = '.'.join( (fileMseedOut,tr.stats.network,tr.stats.station,tr.stats.location,tr.stats.channel,'mseed') )
            fileMseedOut = '/'.join( (dirMseedOut,tr.stats.station,fileMseedOut) )
            #fileMseedOut = '/'.join( (dirMseedOut,fileMseedOut) )
            if tr.stats.network == 'MV':
            #if tr.stats.network == 'TR':
                print( fileMseedOut )
                tr.write(fileMseedOut, format="MSEED")



if __name__ == "__main__":
    main()


