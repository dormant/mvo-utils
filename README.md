# mvo-utils

Various scripts for processing and analysing MVO seismic data.



## carlslogTriggers.pl
## counts

Replacement script to list weekly count of seismic events.

With no arguments, it lists the counts for the last seven days up to 13:00 UTC (9am local time).

### Usage

*counts \<ndays\> \<hourUTC\> \<YYYYMMDD\>*

* ndays: Number of days (default 7)
* hourUTC: Time of end of counting period (default 13)
* YYYYMMDD: Date of end of counting period (default today)

### Issues

*counts* does not work on opsproc3 because *volcstat* doesn't work.

There is an alias to run counts on opsproc2 over ssh: *countsop2*. It needs to be run twice to give the correct results.

## diary2doit.pl
## dodu
## fetch_events
## fetch_events.1.pl
## fetchWWLLNlast24h.sh
## fetchWWLLNyesterday.sh
## findWav
## focmeceps2png
## installligbfortran3.sh
## key-lock-status.sh
## mseedTest.py
## mulplt2vtse
## mulplt2vtse2.pl
## mulplt2vtse.pl
## rbuffers2dsnc.pl
## renameBeg
## scpfrop2
## scptoop2
## selectTest.pl
## setupGlobals
## twenties2mseed.py
## update_counts.sh
## volcstatLess.pl




## Author

Roderick Stewart, Dormant Services Ltd

rod@dormant.org

https://services.dormant.org/

## Version History

* 1.0-dev
    * Working version

## License

This project is the property of Montserrat Volcano Observatory.
