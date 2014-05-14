#!/usr/bin/perl

use strict;
use warnings;

opendir(D,".");
my @files = readdir(D);
closedir(D);

foreach my $file (@files) {
  next if (not $file =~ /\.md$/);
  open FILE, "+< $file" or die $!;
  my $date = "";
  my $plink = $file;
  my $title = "";
  my $newname;
  while (<FILE>) {
    if (/^\s*date\:\s(\d{4}-\d{2}-\d{2})/) {
      $date = $1."-";
    }
    if (/^\s*permalink\:\s(\w+)/) {
      $plink = $1.".md";
    }
    if (/^\s*title\:\s(\w+)/) {
      $1 =~ s/^"//g;
      $1 =~ s/^'//g;
      $1 =~ s/"$//g;
      $1 =~ s/'$//g;
      $title = $1;
    }
    if (/^\s*layout/) {
      $_ =~ s/$_//g;
    }
  }
  $newname = $date.$title;
  print $newname."\n";
  rename $file, $newname;
}
