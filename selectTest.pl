#!/usr/bin/env perl
#
#  Tests select.out for:
#  - existence of data file
#
# R.C. Stewart 2024-08-27

use strict;
use warnings;

my $inputFile;
if( scalar @ARGV == 0 ) {
    print "Need an input file.\n";
    exit;
}
$inputFile = $ARGV[0];

open my $fhi, '<', $inputFile or die $!;

my $evType = '';
my $evVolcType = '';
my $evDate = '';
my $evTime = '';
my $evTag = '';
my $evFile = '';
my $evFileName = '';
my $evFileDir = '';
my $evFileDirStub = '/mnt/mvofls2/Seismic_Data/WAV/MVOE_';
my $lineOut = '';
my $evFileExist = '';

while (my $line = readline($fhi)) {

    chomp $line;

    if( substr($line,-1) eq '1' ) {

        my $strYr = substr( $line, 1, 4 );
        my $strMo = substr( $line, 6, 2 );
        $strMo =~ s/\s/0/;
        my $strDa = substr( $line, 8, 2 );
        $strDa =~ s/\s/0/;
        my $strHr = substr( $line, 11, 2 );
        $strHr =~ s/\s/0/;
        my $strMi = substr( $line, 13, 2 );
        $strMi =~ s/\s/0/;
        my $strSe = substr( $line, 16, 4 );
        $strSe =~ s/\s/0/;
        $evDate = join( '-', $strYr, $strMo, $strDa );
        $evTime = join( ':', $strHr, $strMi, $strSe );
        $evType = substr( $line, 21, 2 );
        #$evType =~ s/^\s+//;
        #$evType =~ s/\s+$//;
        $evFileDir = join( '/', $strYr, $strMo );

    } elsif( substr($line,1,9) eq 'VOLC MAIN' ) {

        $evVolcType = substr( $line, 11, 1 );

    } elsif( substr($line,-1) eq '6' ) {

        my @bits = split ' ', $line;
        $evFile = $bits[0];
        $evFileName = $evFile;
        $evFile = join( '/', $evFileDirStub, $evFileDir, $evFile );

        if( -e $evFile ) {
            $evFileExist = $evFile;
        } else {
            $evFile = join( '.', $evFile, 'bz2' );
            if( -e $evFile ) {
                $evFileExist = $evFile;
            } else {
                $evFileExist = 'No file found';
            }
        }
        $lineOut = join( '  ', $evDate,$evTime,$evType,$evVolcType,$evFileName,$evFileExist);
        print $lineOut, "\n";
        $evFile = '';
        $evFileName = '';

    } elsif( $line =~ /^ *$/ ) {

        $evType = '';
        $evVolcType = '';
        $evDate = '';
        $evTime = '';
        $evTag = '';
        $evFileDir = '';
        $evFileExist = '';
        $lineOut = '';

    }
}

close($fhi);

