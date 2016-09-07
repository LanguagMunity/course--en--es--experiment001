package me::longterm;
use strict;
use chobak_json;

my $critdir;
my $critfile;

$critdir = $ENV{'HOME'};
if ( $critdir eq '' ) { $critdir = `cd && pwd`; chomp($critdir); }
$critdir .= '/.chobakwrap/languamunity-cm-dv01';

$critfile = $critdir . '/memry';
system("mkdir","-p",$critfile);
$critfile .= '/memry.json';


sub get_crit_d {
  return $critdir;
}

sub load {
  my $lc_a;
  $lc_a = &chobak_json::readf($critfile);
  
  if ( ref($lc_a) ne 'HASH' ) { $lc_a = {}; }
  
  &chobak_cstruc::force_hash_has_array($lc_a,'hstry');
  
  
  return $lc_a;
}

sub saveall {
  &chobak_json::savef($_[0],$critfile);
}




1;
