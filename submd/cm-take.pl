use strict;
use me::longterm;
use argola;

my $critdir;
my $our_quiz_file;

$critdir = &me::longterm::get_crit_d();
$our_quiz_file = $critdir . '/quiz-file.json';

while ( &argola::yet() )
{
  system("languamunity","qsp-take","-to",$our_quiz_file,"-in",&argola::getrg());
}

