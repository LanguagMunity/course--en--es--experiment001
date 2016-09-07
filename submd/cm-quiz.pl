use strict;
use argola;
use me::longterm;
use chobak_cstruc;
use File::Basename;
use Cwd 'realpath';
use Scalar::Util qw(looks_like_number);


my $hist_max = 60;
my $hist_asmp = 80;

my $ourdir;
my $memry;
my $histref;
my @histray;
my $lastone;
my $curone;
my $critdir;
my $thisnow;
my $ourfile;
my $ourlcn;
my $ourscrat;
my $average;
my $deckmin;
my $curensize;

$ourlcn = &argola::getrg();

$memry = me::longterm::load();
$histref = $memry->{'hstry'};
$lastone = $memry->{'last'};
$curone = &quizsize();
sub quizsize {
  my $lc_a;
  $lc_a = `languamunity statlli deck+hand`;
  chomp($lc_a);
  return $lc_a;
}
$memry->{'last'} = $curone;



# The following two-block chunk of code is meant to
# maintain the history queue.
if ( looks_like_number($lastone) )
{
  @$histref = (@$histref,int(($lastone - $curone) + 0.2));
}
while ( &chobak_cstruc::counto($histref) > ( $hist_max + 0.5 ) )
{
  &chobak_cstruc::ry_shift($histref);
}

@histray = @$histref;
while ( &counto(@histray) < 1.5 ) { @histray = ($hist_asmp,@histray); }
sub counto {
  my $lc_a;
  $lc_a = @_;
  return $lc_a;
}
while ( &counto(@histray) < ( $hist_max + 0.5 ) ) { @histray = (@histray,@histray); }
while ( &counto(@histray) > ( $hist_max + 0.5 ) ) { shift(@histray); }
while ( &counto(@histray) > ( ( $hist_max - 0.3 ) / 2 ) )
{
  shift(@histray);
  pop(@histray);
}
{
  my $lc_tot;
  my $lc_iqr;
  my $lc_each;
  
  $lc_iqr = &counto(@histray);
  $lc_tot = 0;
  foreach $lc_each (@histray)
  {
    $lc_tot = int($lc_each + $lc_tot + 0.2);
  }
  $average = ( $lc_tot / $lc_iqr );
}
$deckmin = int($average * 4.3);
system("echo","Deck Minimum Calculated to: $deckmin:");


$ourdir = dirname(dirname(realpath($0)));
$ourfile = $ourdir . '/comres/sh/lcn-' . $ourlcn . '.sh';


# Make sure the names are set right ....
system("languamunity","clear-names");
system("languamunity","lc-take",($ourdir . "/res/names.json"));


if ( !( -f $ourfile ) ) { die ( "\nNo such lesson: " . $ourlcn . ":\n\n" ); }

$critdir = &me::longterm::get_crit_d();

$thisnow = `date +%s`; chomp($thisnow);
$ourscrat = $critdir . '/scratch/at-' . $thisnow;
system("mkdir","-p",$ourscrat);
{
  my $lc_a;
  my @lc_b;
  my $lc_c;
  my $lc_d;
  my $lc_e;
  $ENV{"LANGDRILL_X_MAIN"} = $critdir;
  $ENV{"LANGDRILL_X_SUSCRAT"} = ($critdir . '/scratch');
  $ENV{"LANGDRILL_X_SHRS"} = ($ourdir . '/comres/sh');
  $lc_a = `ls -1d \"\${LANGDRILL_X_SUSCRAT}\"/*-* 2> /dev/null`;
  @lc_b = split(/\n/,$lc_a);
  foreach $lc_c (@lc_b)
  {
    ($lc_d,$lc_e) = split(quotemeta('-'),$lc_c);
    if ( $lc_d eq 'at' )
    {
      if ( ( $thisnow - $lc_e ) > ( 60 * 10 ) )
      {
        system("echo","rm","-rf",($critdir . '/scratch/' . $lc_c));
      }
    }
  }
}


$ENV{"LANGDRILL_X_OURDIR"} = $ourdir;
$ENV{"LANGDRILL_X_LCDIR"} = ($ourdir . '/lcn');
$ENV{"LANGDRILL_X_SCRAT"} = $ourscrat;

$curensize = &quizsize();
system("rm","-rf",$ourscrat);
while ( $curensize < ( $deckmin - 0.5 ) )
{
  system("echo","Current Quiz-Size: $curensize --- must increase to at least $deckmin --");
  sleep(1);
  system("mkdir","-p",$ourscrat);
  system("sh",$ourfile);
  system("rm","-rf",$ourscrat);
  $curensize = &quizsize();
}
system("echo","Goal Quiz-Size - Acheived ---- Quiz-size: $curensize");
sleep(1);

&me::longterm::saveall($memry);

exec(($ourdir . "/com/resume"));






