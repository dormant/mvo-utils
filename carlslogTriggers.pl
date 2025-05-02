#!/usr/bin/perl
#
# Extracts trigger info from carlslog files into daily text files
#
# R.C. Stewart 2022-12-07
#

use strict;
use warnings;

my $dirCarlslogs = '/mnt/mvofls2/Seismic_Data/monitoring_data/carlslogs';
my $dirTrigs = '/mnt/mvofls2/Seismic_Data/monitoring_data/triggers/carlslogTriggers/triggerLists';

opendir(DIR, $dirCarlslogs);
my @files = grep { /carlsub/ } readdir(DIR);
closedir(DIR);

foreach my $file (@files) {

    $file = join('/', $dirCarlslogs, $file );
    if( -M $file < 3 ){
        my $dateLog = substr( $file, -12, 8 );
        my $outFile = join( '', $dirTrigs, '/', 'carlsubtrigs-', $dateLog, '.txt' );
        print "$outFile\n";
        open(FHO, '>', $outFile) or die $!;

        my $partOneLine = '';
        my $partTwoLine = '';
        my $partThreeLine = '';

        open(FH, $file )or die "Not opening";
        foreach my $line (<FH>)
        {
            chomp $line;

            if( $line =~ /v2.0 EVENT/ ) {
                $partTwoLine = join( '-', substr( $line, 24, 4 ), substr( $line, 28, 2 ), substr( $line, 30, 2) );
                $partTwoLine =~ s/ /0/;
                $partTwoLine = join( ' ', $partTwoLine, substr( $line, 33, 10 ) );
                $line =~ /(EVENT ID:\s\d+)/;
                $partThreeLine = $1;
                $partThreeLine =~ s/://;
                $partThreeLine =~ s/\s/_/g;
                printf FHO "%19s    %-37s %s\n", $partTwoLine, $partThreeLine, $partOneLine;
                #print "$partTwoLine    Earthworm event     $partOneLine\n";
            }
            elsif( $line =~ /^   Subnet 0/ ) {
                $partOneLine = substr( $line, 13 );
            }
        }

        close(FHO);
    }
}
