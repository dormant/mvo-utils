#!/usr/bin/perl -w
use strict;

# Name:           fetch_events
# Source:         /data2/development/fetch_events/fetch_events.pl
# Arguments:      none
# Returns:        0 on success 1 on failure

# Copies new event files from earthworm to working directory.
# Knows which are new by looking for s-files in REA database.
# If rerun before analysis done will recopy unprocessed events but this is no problem.
# Runs dirf at end to create filenr.lis ready for analysis.

# Get files from earthworm rather than via dome so user can delete in mulplt 

# Configuration
#my $debug           = 0; 
my $debug           = 1; 
#my $source_path     = "/CURRENT_EARTHWORM/monitoring_data/events";
my $source_path     = "/mnt/mvofls2/Seismic_Data/monitoring_data/events";
my $target_path     = "$ENV{SEISAN_TOP}/WOR";
my $sfile_path      = "$ENV{SEISAN_TOP}/REA/MVOE_";

# Local variables
my $line;                # Return from system call
my ($wavfile,@wavfiles); # For looping over events directory
my ($year,$month,$time); # Bits of date needed for sfile path/filename
my $count=0;             # Counter for number of events fetched

# Check that everything is mounted
unless (-e $source_path){
	die "$source_path: path not available.\n";
}
unless (-e $sfile_path){
	die "$sfile_path: path not available.\n";
}
unless (-e $target_path){
	die "$target_path: path not available.\n";
}

# Use ls to do reverse sort in source directory so start with newest files
@wavfiles = `ls -r $source_path 2>&1`;
die "ERROR: fetch_events: $wavfiles[0]\n" if ($?);

# Loop over files until get to one that's been done already
foreach $wavfile (@wavfiles){

	chomp ($wavfile);

	# Parse line to extract filename and bits for sfile directory/filename
	# Only interested in SEISAN format files 
	#unless ($wavfile =~ /(\d\d\d\d)\-(\d\d)\-(\d\d\-\d\d\d\d\-\d\d)S\.MVO___\d\d\d$/){
	unless ($wavfile =~ /(\d\d\d\d)\-(\d\d)\-(\d\d\-\d\d\d\d\-\d\d)S\.MV____\d\d\d$/){
		print "Skipping $source_path/$wavfile\n" if ($debug);
		next;
	}
	$year=$1; $month=$2; $time=$3;

	# See if s-file exists
	$line = `ls $sfile_path/$year/$month/$time?.S$year$month 2>&1`;

	# If status = 0 then found s-file, no more to do
	last unless ($?);

	# Check status wasn't 1 for bad reason
	if ($line !~ /No such file or directory/){
		die "ERROR: fetch_events: $source_path/$wavfile: $line\n";
	}

	# Otherwise copy file over
	$line = `cp $source_path/$wavfile $target_path 2>&1`;
	die "ERROR: fetch_events: $line\n" if ($?);

	print "Copied $source_path/$wavfile to $target_path\n" if ($debug);
	$count++;
}

# Create filenr.lis for mulplt to read - 
# get all wavfiles in WOR in case some there already.
if ($count){
	print `dirf [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]-* 2>&1`;
	die "ERROR: fetch_events: dirf: $line\n" if ($?);
}

exit(0);
