#!/usr/bin/perl
# 2015-05-23 (cc) paul4hough@gmail.com

eval 'exec perl -w -S $0 ${1+"$@"}'
    if 0 ;

use warnings;
use strict;
#use DBI;
#use DBD::Pg qw(:pg_types);
#use File::Basename;
use File::Find;
#use MP4::File;
#use Meta::TMDb;
#use Meta::IMDB;
#use Term::ReadLine;
#use Data::Dumper;
#use POSIX;
#use Text::CSV;
#use DVD::Read;
#use Encode;
#use LWP;
#use MP4::Info;
#use XML::Parser;
#use Imager;
use X11::Resolution;
use List::Util 'shuffle';

our $freq = (@ARGV > 0 ? $ARGV[0] : 15);
our $picBaseDir = "$ENV{HOME}/.desktop_pictures";
our $res = "640x480";
our @pics;

my $pidfn = "$ENV{HOME}/.pid.wallpaper";
open(my $pidfh,">",$pidfn);
print $pidfh "$$\n";
close($pidfh);

my $x11res=X11::Resolution->new();
if($x11res->{error}){
    die "Error:".$x11res->{error}.": ".$x11res->{errorString}."\n";
}

my ($rx, $ry)=$x11res->getResolution;

$res = "$rx"."x"."$ry";

$SIG{'ALRM'} = sub{ print "next image\n"; };

sub found {
    if( -f $_ ) {
	push(@pics,$File::Find::name);
    }
}


find( \&found, $picBaseDir );

my $tcnt = 0;
foreach my $img (shuffle(@pics)) {

    my @opts = ('-backdrop',
		'-background',
		'#3f3f3f',
		'-flatten',
		'-resize',
		"$res^",
		'-window',
		'root',
		'-gravity',
		'Center',
	);
    if( $img =~ /background/i ) {
	print "bg  ";
	push( @opts, '-crop', "$res+0+0", '+repage','-resize',"$res^");
	++ $tcnt;
    } else {
	print "pic ";
    }
    print "$img\n";
    #print join(',',@opts)."\n";
    if( $tcnt > 10 ) { exit; }
    system('display',@opts,$img);
    open(my $tfh, ">","$picBaseDir/../.wallpaper.imgfn.txt");
    print $tfh "$img\n";
    close($tfh);
    sleep($freq);
}


## Local Variables:
## mode:perl
## end:
