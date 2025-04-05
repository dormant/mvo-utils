#!/bin/bash
#
# update_counts.sh
#
# Simple bash script to run select, collect, volcstat and create files for megaplot2 andothers
#
# RCS, 17-Dec-2019, 14-Jan-2021

### Set some variables
source /home/seisan/seismo/COM/SEISAN.bash
# working directory for seisan commands
work_dir='/home/seisan/seismo/TMP/'
mkdir -p ${work_dir}
# output directory
#out_dir='/home/seisan/Rod/update_counts'
out_dir='/mnt/mvofls2/Seismic_Data/monitoring_data/seisan'

# end time => define to be NOW!
endtime=`date -u +%Y%m%d%H%M%S`

### Use seisan "select" command

# change to working directory
cd ${work_dir}

date
echo select

# execute select command
/home/seisan/seismo/PRO/select  &> select.log << EOF

s
19960101000000
$endtime
24
t
r
h
l
e
s
n
m



EOF

date
echo collect

# execute collect command
/home/seisan/seismo/PRO/collect  &> collect.log << EOF

19960101000000
$endtime
Y
EOF

date
echo volcstat

# execute volcstat command
/home/seisan/seismo/PRO/volcstat &> volcstat.log << EOF

19960101000000
$endtime
1
ehlrtxsnm
n
EOF

date
echo copy

### Copy output to directory 

cp select.out ${out_dir}
cp collect.out ${out_dir}
cp volcstat_daily_*.out ${out_dir}

date
echo done
