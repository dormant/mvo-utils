#!/usr/bin/perl
#
# Mimics some features of volcstat, without the bug that missed the last day
#
# R.C. Stewart, 2022-01-21
#

use strict;
use warnings;
use DateTime;
#use feature qw(switch);

my @events = ();
my @volctypes = ();
my $file = '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/select.out';
open my $info, $file or die "Could not open $file: $!";
my $iev = -1;
while( my $line = <$info>)  {   
    chomp $line;
    if( substr( $line, 21, 2 ) eq 'LV' ) {
        #print $line, "\n";
        $iev++;
        $events[$iev] = substr( $line, 1, 19 );
    }
    elsif( $line =~ /^ VOLC MAIN/ ){ 
        #print $line, "\n";
        $volctypes[$iev] = substr( $line, 11, 1 );
    }
}
close $info;
my $nev = scalar( @events );


# Create array of datestrings 
my @dates = ();
my $start = DateTime->new(
    day   => substr( $events[0], 7, 2 ) + 0,
    month => substr( $events[0], 5, 2 ) + 0,
    year  => substr( $events[0], 0, 4 ) + 0,
);

my $stop = DateTime->new(
    day   => substr( $events[-1], 7, 2 ) + 0,
    month => substr( $events[-1], 5, 2 ) + 0,
    year  => substr( $events[-1], 0, 4 ) + 0,
);


while ( $start->add(days => 1) <= $stop ) {
    push( @dates,  $start->ymd('') );
}

#print scalar(@dates), "\n";
#print $dates[0], "\n";
#print $dates[-1], "\n";

# Create hashes for daily counts
my %daily_e = ();
my %daily_h = ();
my %daily_l = ();
my %daily_m = ();
my %daily_n = ();
my %daily_r = ();
my %daily_s = ();
my %daily_t = ();
my %daily_x = ();

foreach my $date( @dates ) {
    $daily_e{$date} = 0;
    $daily_h{$date} = 0;
    $daily_l{$date} = 0;
    $daily_m{$date} = 0;
    $daily_n{$date} = 0;
    $daily_r{$date} = 0;
    $daily_s{$date} = 0;
    $daily_t{$date} = 0;
    $daily_x{$date} = 0;
}



# Go through all events and add to count hashes
for ( my $iev = 0; $iev < $nev; $iev++ ) {

    my $year = substr( $events[$iev], 0, 4 ) + 0;
    my $month = substr( $events[$iev], 5, 2 ) + 0;
    my $day = substr( $events[$iev], 7, 2 ) + 0;
    my $dateEvent = sprintf( "%4d%02d%02d", $year, $month, $day );
    my $typeEvent = $volctypes[$iev];
    #print $dateEvent, $typeEvent, $events[$iev], "\n";

    #    given($typeEvent){
    #    when('e') { $daily_e{ $dateEvent }++ }
    #}
    
    if( $typeEvent eq 'e' ) {
        $daily_e{ $dateEvent }++;
    }
    elsif( $typeEvent eq 'h' ) {
        $daily_h{ $dateEvent }++;
    }
    elsif( $typeEvent eq 'l' ) {
        $daily_l{ $dateEvent }++;
    }
    elsif( $typeEvent eq 'm' ) {
        $daily_m{ $dateEvent }++;
    }
    elsif( $typeEvent eq 'n' ) {
        $daily_n{ $dateEvent }++;
    }
    elsif( $typeEvent eq 'r' ) {
        $daily_r{ $dateEvent }++;
    }
    elsif( $typeEvent eq 's' ) {
        $daily_s{ $dateEvent }++;
    }
    elsif( $typeEvent eq 't' ) {
        $daily_t{ $dateEvent }++;
    }
    elsif( $typeEvent eq 'x' ) {
        $daily_x{ $dateEvent }++;
    }
}

open( FHE, '>', '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/volcstat_daily_e-fixed.out' ) or die $!;
open( FHH, '>', '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/volcstat_daily_h-fixed.out' ) or die $!;
open( FHL, '>', '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/volcstat_daily_l-fixed.out' ) or die $!;
open( FHM, '>', '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/volcstat_daily_m-fixed.out' ) or die $!;
open( FHN, '>', '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/volcstat_daily_n-fixed.out' ) or die $!;
open( FHR, '>', '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/volcstat_daily_r-fixed.out' ) or die $!;
open( FHS, '>', '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/volcstat_daily_s-fixed.out' ) or die $!;
open( FHT, '>', '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/volcstat_daily_t-fixed.out' ) or die $!;
open( FHX, '>', '/mnt/mvofls2/Seismic_Data/monitoring_data/seisan/volcstat_daily_x-fixed.out' ) or die $!;
foreach my $date( sort @dates ) {
    printf FHE "%8s %6d\n", $date, $daily_e{$date};
    printf FHH "%8s %6d\n", $date, $daily_h{$date};
    printf FHL "%8s %6d\n", $date, $daily_l{$date};
    printf FHM "%8s %6d\n", $date, $daily_m{$date};
    printf FHN "%8s %6d\n", $date, $daily_n{$date};
    printf FHR "%8s %6d\n", $date, $daily_r{$date};
    printf FHS "%8s %6d\n", $date, $daily_s{$date};
    printf FHT "%8s %6d\n", $date, $daily_t{$date};
    printf FHX "%8s %6d\n", $date, $daily_x{$date};
}
close( FHE );
close( FHH );
close( FHL );
close( FHM );
close( FHN );
close( FHR );
close( FHS );
close( FHT );
close( FHX );
