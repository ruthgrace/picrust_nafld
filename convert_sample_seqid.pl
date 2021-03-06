#!/usr/bin/perl -w
use strict;
use Cwd;
use warnings;

my $infile = $ARGV[0] if $ARGV[0];
my $outfile = $ARGV[1] if $ARGV[1];
print "This function takes in two arguments: the path of the input fasta file, and the path of the output fasta file\n" if !$ARGV[0];
print "This function takes in two arguments: the path of the input fasta file, and the path of the output fasta file\n" if !$ARGV[1];
exit if !$ARGV[0];
exit if !$ARGV[1];

open (IN, "< $infile") or die "$!\n";
unless(open OUT, '>', $outfile) {
    print "\nUnable to open $outfile: $!\n";
}
my $sample;
my $seqid;
my $underscoreIndex;
my $underscore = '_';
while(defined(my $l = <IN>)){
  chomp $l;
  if ($l =~ /^>/) {
    $l =~ s/^>//;
    $l =~ s/NASH_FO/NASH.FO/;
    $underscoreIndex = index($l, $underscore);
    $seqid = substr $l, 0, $underscoreIndex;
    $sample = substr $l, $underscoreIndex + 1, length($l) - $underscoreIndex - 1;
    $sample =~ s/_/./;
    print OUT ">" . $sample . "_" . $seqid  . "\n";
  }
  else {
    print OUT "$l\n";
  }
}

close IN;
close OUT;
