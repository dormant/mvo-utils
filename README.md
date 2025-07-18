# utils

## ~/src/utils

Various scripts for processing and analysing MVO seismic data.


## carlslogTriggers.pl, carlslogTriggersPlot.sh

* Extracts trigger information from *earthworm* carlslog files.
* Plots triggering events using *getnPlot*.
* Trigger lists stored in daily text files in */mnt/mvofls2/Seismic_Data/monitoring_data/triggers/carlslogTriggers/triggerLists*. You have to manually move them to the year directories.
* Trigger plots stored in */mnt/mvofls2/Seismic_Data/monitoring_data/triggers/carlslogTriggers/triggerPlots*.
* Run daily as cronjobs on *opsproc3*.
```
# Collect earthworm triggered event list
7 4 * * * /home/seisan/src/utils/carlslogTriggers.pl >/home/seisan/log/carlslogTriggers.log 2>&1
17 4 * * * bash -i /home/seisan/src/utils/carlslogTriggersPlot.sh >/home/seisan/log/carlslogTriggersPlot.log 2>&1
```

## counts

Replacement script to list weekly count of seismic events.

With no arguments, it lists the counts for the last seven days up to 13:00 UTC (9am local time).

### Usage

*counts \<ndays\> \<hourUTC\> \<YYYYMMDD\>*

* ndays: Number of days (default 7)
* hourUTC: Time of end of counting period (default 13)
* YYYYMMDD: Date of end of counting period (default today)

### Bugs / Issues

*counts* does not work on *opsproc3* for periods longer than about a month because of a bug in *volcstat*.

There is an alias to run *counts* on opsproc2 over ssh: *countsop2*.

## dodu

Lists disk space and disk usage in a useful way.

### Bugs / Issues

The year is hard-wired in the script.

## fetch_events, fetch_events.1.pl

* Script to copy new event files from *earthworm* to the current directory.
* Modified from the original to generate a plot of each event using *getnPlot* and display it.
* The original script is *fetch_events_1.pl*.
```
alias fe='fetch_events'
alias fe0='fetch_events.1.pl'
```
## fetchHelis

* Copies helicorder plots and montages for one day to current directory.

### Usage

*fetchHelis yyyymmdd STA*

## fetchHelis.sh

* Copies helicorder montages and MSS1 helicorder for one day to current directory.
* Used in string analysis.

### Usage

*fetchHelis.sh yyyymmdd*

## fetchMseed

* Copies miniseed files for MV network for a given date to current directory.

### Usage

*fetchMseed yyyymmdd*

## fetchWWLLNlast24h.sh, fetchWWLLNyesterday.sh

* Fetch data from the WWLLN Volcanic lightning monitor.
* Output stored in */mnt/mvofls2/Seismic_Data/monitoring_data/other/wwlln/*.
* Run as cronjobs on *opsproc3*.

## findCorruptHelis

* Uses *exiftool* to find corrupt helicorder plots on *earthworm03*.

## findWav

* Finds WAV files in the continous *SEISAN* database for a given date, time and duration.
* Used by *getnPlot*.

### Usage

*findWav yyyy-mm-dd hh:mm:ss \<window\>*

* window: duration in minutes of period of interest.

## focmeceps2png

* Converts eps files created by focmec to png files.
* Converts every eps file in current directory.
* png files are cropped and modified.

## hypo2csv

* Converts text file with hypocentre information to a csv file suitable for *gpsbabel*.

### Usage
```
$ hypo2csv dataFile.txt
```

## infoComputer

* Lists setup information for a Linux computer.

### Usage
```
$ infoComputer > infoComputer-winston1.txt
```
### Bugs

* Doesn't detect hardware or disks on virtual computers: *inxi* doesn't work.

## installligbfortran3.sh

* Downloaded script to install *libgfortran3* on a modern *Linux*.
* Does not work in all operating systems.
* Has potential to affect *gcc*.

## key-lock-status.sh

* Downloaded script to display Caps Lock status in Linux toolbar.
* Needs to be added to toolbar.

## mseedTest.py

Lists information about every miniseed file in the current directory.

## mulplt2vtse, mulplt2vtse2.pl, mulplt2vtse.pl

Scripts used when processing VT strings with *mulplt*.

### Usage

```
$ mulplt2vtse yyyymmdd-hhmm
```

* yyyymmdd-mmhh: name of input .tmp file (with or without eextension) created from mulplt.
* yyyymmdd-hhmm.txt: Output text file to be saved for string analysis.
* yyyymmdd-hhmm-formatted.txt: Alternative output text file.


## rbuffers2dsnc.pl

* Copies 20-minute SEISAN files from */mnt/mvofls2/Seismic_Data/rbuffers* to the structured directory tree in */mnt/mvofls2/Seismic_Data/WAV/DSNC_*.
* Compresses each file using *bzip2*.
* Runs once a month as a cronjob on *opsproc3*.

## reg_event

* Used by *mulplt* when registering events.
* No idea who wrote this.

## renameBeg

Renames file(s), adding a string to the beginning of every file name.

### Example usage

*renameBeg TextAtStart \*.jpg*

## scpfrop2, scptoop2

Copies files to and from *~seisan/seismo/WOR_ROD* on *opsproc2* using *scp*.

### Bugs / Issues

The scripts don't work properly.

## selectTest.pl

Checks contents of *select.txt* for the existence of data files in MVOE_.

## setupGlobals

Sets up an environment variable, *SETUP*, which can be used by other scripts.

### Bugs / Issues

This was an attempt to mimic something I found useful in MATLAB. This approach was never implemented in other scripts.

## sync_seismic_winston1

* Synchronises seismic data on winston1 with /mnt/mvofls2/Seismic_Data.
* Runs as a cronjob on *winston1* every 20 minutes by user *mvo*.
```
# Sync mseed and rbuffers files with mounted volume
1,21,41   *   *   *   *   /home/mvo/bin/sync_seismic_winston1 >> /home/mvo/log/sync_seismic_winston1-`date +\%Y\%m\%d`.log 2>&1
```


## tarbackup

* Creates full and incremental backups for Linux machines
* Backups stored in */mnt/mvohvs3/MVOSeisD6/backups/automatic/*.
* Run as a daily cronjob for each user.
```
# Daily incremental backups
0 2 * * 0 /home/wwsuser/bin/tarbackup > /home/wwsuser/log/tarbackup.log 2>&1
0 2 * * 1,2,3,4,5,6 /home/wwsuser/bin/tarbackup inc > /home/wwsuser/log/tarbackup.log 2>&1
```


## twenties2mseed.py

* Creates 24-hour single-channel miniseed files from 20-minute *SEISAN* files.
* Uses all files in the current directory.
* Output saved in */mnt/mvohvs3/MVOSeisD6/mseed/MV-fromTwenties*.

## update_counts.sh

* Runs *select*, *collect* and *volcstat* for the entire *SEISAN* database.
* Output saved in */mnt/mvofls2/Seismic_Data/monitoring_data/seisan*. 
* Runs daily as a cronjob on *opsproc2*.

### Bugs / Issues

Does not run properly on *opsproc3* because of the problems with *SEISAN*.

## volcstatLess.pl

* Mimics (partly) *volcstat*, but without the error that misses the last day.
* Output saved in */mnt/mvofls2/Seismic_Data/monitoring_data/seisan/* in files *volcstat_daily_?-fixed.out*.


## Author

Roderick Stewart, Dormant Services Ltd

rod@dormant.org

https://services.dormant.org/

## Version History

* 1.0-dev
    * Working version

## License

This project is the property of Montserrat Volcano Observatory.
