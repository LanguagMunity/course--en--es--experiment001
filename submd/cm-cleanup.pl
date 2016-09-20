use strict;
use me::longterm;

my $critdir;
my $our_quiz_file;

$critdir = &me::longterm::get_crit_d();
$our_quiz_file = $critdir . '/quiz-file.json';
system("languamunity","clear-quiz","-pmiss","-f",$our_quiz_file);

