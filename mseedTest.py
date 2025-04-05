#!/usr/bin/env python
# mseedTest.py
#
# Reports information about all mseed files in curren t directory
#
# R.C. Stewart, 9-August-2024
#
import os
import sys
import glob
import argparse
import re
import obspy
from datetime import datetime, date, timedelta
from dateutil import parser as dparser
from dateutil.rrule import rrule, DAILY
from obspy.core import UTCDateTime, Stream



for filename in os.listdir("."):
    if filename.endswith(".msd") or filename.endswith(".mseed"): 

        print( filename )

        st = obspy.read( filename )
        print( st.__str__(extended=True) )


