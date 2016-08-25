# Participating as a MacOS X Tester of LanguaMunity at This Stage
__NOTE: This document isn't yet ready for anyone to use.
Please check back in a few days.__

An Open Source project such as LanguaMunity needs [help of all kinds](thanks.md).
One kind of help that is very much needed is for people to participate
as testers - people who will try it out and submit feedback by which
the project may improve.

This document details how users of MacOS X may participate in testing
this idea of LanguaMunity as it forms as well as the terminal-window implementation
of LanguaMunity.

## Step 1 - Make Sure TextWrangler is Installed
If you have TextWrangler \(or it's full-featured
sister-project, BBEdit\) already installed on your
system, complete with the __edit__ user-command
\(and have verified that __edit__ works from your
command-line\)
you can skip this step.
Otherwise, this step is important.

There are two ways to install TextWrangler.
One is [through the app store](https://itunes.apple.com/us/app/textwrangler/id404010395?mt=12)
- though if you install it that way, you will still have to go to the program's
web-site in order to install the __edit__ user-command as it is not included
in the app-store edition of the program.

The other way is to
[download and install it yourself](http://www.barebones.com/support/textwrangler/updates.html)
- and if you do it this way, they probably are the ones who can tell you whether
or not you have to do an extra step to install the __edit__ user-command.

Either way, there may be additional instructions you have to follow to assure
that the __edit__ user-command is on the command-path, so that you can easily
use it from the command-line.

## Step 2 - Make sure Git is installed
If __git__ is not installed, you can
[download and install it from the Git-SCM web-site](https://git-scm.com/download/mac).

## Step 3 - Open the terminal
The terminal is accessed through an application named "Terminal"
which is in the "Utilities" folder within the "Applications" folder.

When you open this app it will automatically open a terminal window.

Also - an icon will appear in your dock for the terminal when the app is
open. To make it easier to open the terminal in the future,
right-click on it's icon in the dock, and select the option "Keep in dock".

To open a new terminal window when the Terminal application is already open,
click on "Shell" in the menu bar, then select "New Window" >
"New Window with Settings - Basic".

## Step 4 - Make sure the JSON CPAN module for PERL is installed
To do this step, you will need to create a PERL script that does all
the testing and, if necessary, all the installation - and then run that script.

To create the script first open the text-editing window with the following
set of commands:

    mkdir -p ~/tmp
    edit ~/tmp/assure-json-installed.pl

Then, when the editing window opens, simply copy-paste the following
file contents into the window, save, and close the window.

    use strict;
    
    &func_install_json();
    
    sub func_install_json {
      my $lc_test;
      
      # If JSON is installed, we can already return to the
      # calling program.
      $lc_test = 10;
      if(system("perl -e \"use JSON;\"")) { $lc_test = 0; }
      system("echo","\n\nJSON Presend Test:\nTEST RESULT: " . $lc_test);
      if ( $lc_test > 5 ) { return; }
      
      # If not, we first must install CPANM - and then install
      # JSON:
      &func_install_cpanm();
      system("sudo cpanm -i JSON");
    }
    
    sub func_install_cpanm {
      my $lc_loca;
      
      $lc_loca = `which cpanm`; chomp($lc_loca);
      if ( $lc_loca ne '' ) { return; }
      
      system('sudo chown -R "$(whoami)" ~/.cpanm');
      system('curl -L http://cpanmin.us | perl - --sudo App::cpanminus');
      system('sudo chown -R "$(whoami)" ~/.cpanm');
    }
    

Then, run the script by entering the following command in the terminal.

    perl ~/tmp/assure-json-installed.pl

Upon doing this, if you are prompted for a password,
enter the same password that you enter to log on to your
Mac.
