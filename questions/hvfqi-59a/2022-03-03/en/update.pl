#! /usr/bin/perl

use File::Slurp qw( read_file );
use JSON::XS;

my $text          = read_file( 'questionnaire.en.json' );
my $json          = new JSON::XS();
my $questionnaire = $json->decode( $text );
my $questions     = $questionnaire->{ questions } = [];

my $question      = { response => { type => 'likert' }};
my $prev          = 0;
open my $fh, '<', 'questionnaire.en.txt' or die $!;
while( <$fh> ) {
	s/^\s+//;
	s/\s+$//;
	my ($num, $text) = /^(\d+(?:\.\d+)?)\.\s+(\w.*)$/;

	$question->{ text } = $text;

	if( int( $num ) != $num + 0.0 ) {
		my $i       = int( $num ) - 1;
		my $leading = $questions->[ $i ];
		print STDERR "Found follow-up $num\n";
		push @{$leading->{ follow }{ ups }}, $question;
		$question = { response => { type => 'likert' }};

	} else {
		print STDERR "Found leading $num\n";
		push @$questions, $question;
		$question = { response => { type => 'likert' }};
	}
	$prev = int( $num );
}
push @$questions, $question;
close $fh;

print $json->canonical->pretty->encode( $questionnaire );
