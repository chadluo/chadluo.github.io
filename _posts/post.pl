#!/usr/bin/perl

use strict;
use warnings;

# hexo:
#   permalink.md
#   title: title;
# jekyll:
#   year-month-date-permalink.md
#   title: title;

opendir(D,".");
my @files = readdir(D);
closedir(D);

foreach my $file (@files) {
  next if (not $file =~ /\.md$/);
  print $file "---\n" if $. == 1;
  open FILE, "+< $file" or die $!;
  my $date = "";
  my $plink = $file;
  my $newname;
  while (<FILE>) {
    if (/^\s*date\:\s(\d{4}-\d{2}-\d{2})/) {
      $date = $1."-";
    }
    if (/^\s*permalink\:\s(\w+)/) {
      $plink = $1.".md";
    }
    if (/^\s*title/) {
      s/$_/title\: '$file'/g;
    }
    if (/^\s*layout/) {
      $_ =~ s/$_//g;
    }
  }
  $newname = $date.$plink;
  print $newname."\n";
  rename $file, $newname;
}
