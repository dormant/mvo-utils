#!/usr/bin/perl
#
# Takes a mulplt.out where VT string events have been picked and converts to a text format that I use.
#
# R.C. Stewart, 22-Jul-2021

while (<>) {

	my $line = $_;
	chomp $line;

	my $last = substr( $line, -1 );

	if( $last eq '1' ) {
		#print $line, "\n";
		my $year = substr( $line, 1, 4 ) + 0;
		my $month = substr( $line, 6, 2 ) + 0;
		my $day = substr( $line, 8, 2 ) + 0;
		printf "%4d-%02d-%02d ", $year, $month, $day;
	} elsif ( $last eq ' ' ) {
		if( substr( $line, 0, 2 ) ne '  ' ) {
			#print $line, "\n";
			my $hour = substr( $line, 18, 2 ) + 0;
			my $minute = substr( $line, 20, 2 ) + 0;
			my $second = substr( $line, 22, 6 ) + 0;
			printf "%02d:%02d:%04.1f\n", $hour, $minute, $second;
		}
	}
}
