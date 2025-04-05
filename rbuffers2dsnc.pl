#!/usr/bin/perl
#
# To be run on one day of every month, copies 20-minute files from rbuffers to WAV/DSNC_ directory tree,
# and compressing them
#
# R.C. Stewart 2024-08-29
#

use strict;
use warnings;
use DateTime;
use DateTime::Duration;
use Cwd qw(getcwd);
use Time::HiRes qw( time );


my $dur = DateTime::Duration->new(
    years        => 0,
    months       => 1,
    weeks        => 0,
    days         => 0,
    hours        => 0,
    minutes      => 0,
    seconds      => 0,
    nanoseconds  => 0,
);

my $begin_time = time();

my $dirStart = getcwd();

my $dirRbuffers = "/mnt/mvofls2/Seismic_Data/rbuffers";
my $dirWav = "/mnt/mvofls2/Seismic_Data/WAV/DSNC_";

my $dt   = DateTime->now;
print "$dt\n";
$dt->subtract_duration($dur);
my $year = sprintf( "%4d", $dt->year );
my $month = sprintf( "%02d", $dt->month );

my $dirWavYear = join( '/', $dirWav, $year );
my $dirWavYearMonth = join( '/', $dirWav, $year, $month );

if (! -e $dirWavYear) {
    mkdir( $dirWavYear ) or die "Can't create $dirWavYear: $!\n";
}
if (! -e $dirWavYearMonth) {
    mkdir( $dirWavYearMonth ) or die "Can't create $dirWavYearMonth: $!\n";
}


chdir $dirWavYearMonth;

my $cmd = sprintf( "/usr/bin/cp %s/%s_%s_*.msd .", $dirRbuffers, $year, $month );
print $cmd, "\n";
system( $cmd );

$cmd = "/usr/bin/bzip2 *.msd";
print $cmd, "\n";
system( $cmd );

chdir $dirStart;

my $end_time = time();
printf("Elapsed time (s): %.2f\n", $end_time - $begin_time);

print "\n";
