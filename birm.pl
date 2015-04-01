#!/usr/bin/perl -w
#
# preprocessor for Burmese transliterated text preparing it to be typeset as Burmese by 
# LaTeX
# author: Johannes Reese
# date: 6 July 2002
# version: 0.003 (5 August 2002)
# bug reports and comments to: reese@linguist.de
#
# Usage: perl birm.pl <FILE> (without ending; takes <FILE>.bir, produces <FILE>.tex)
#
# description: changes transcribed Burmese syllables into the right character 
#              numbers for processing them with LaTeX, only those inside an environment 
#              started with {\birm. TeX commands inside such an environment will be left
#              unchanged, only the arguments of \textbf, \emph, \textsc, and \textsf 
#              will be changed, too; however, at present, these commands have no effect, 
#              as only one script style is provided so far.
# warnings: syllables must end with a space (or punctuation sign plus space)
#
#
# Copyright (c) Joh. Reese 2002
#
# This file is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
#  IMPORTANT COPYRIGHT NOTICE:
#
#  Permission is granted to copy this file to another file with a clearly
#  different name and to customize the declarations in that copy to serve
#  the needs of your installation, provided that you do not remove this
#  notice or original copyright notice.

#  However, NO PERMISSION is granted to produce or to distribute a
#  modified version of this file or the ones bound with the package 
#  under its original name.

#  You are NOT ALLOWED to change this file.
#
#
if("$ARGV[0].tex")   # protects possibly existing files
{
    print "The file to be produced already exists! Shall it be destroyed, press y\n";
    $Eingabe = <STDIN>;
    if($Eingabe eq "y\n")
    {
	unlink("$ARGV[0].tex");
	print "done!\n";
    }
    else
    {
	print "Okay, don't worry! Nothing happened\n";
	die;
    }
}
open(IN, "$ARGV[0].bir"); # the file with the transliterated text
open(OUT, ">>$ARGV[0].tex"); # the tex-file with the input for Burmese; non-Burmese
# text is left unchanged
$Schalter = 0; # as long as this is 0, nothing will be changed
while(<IN>)
{
    $Line = $_;
    $CharPos = 0;
    $Letzt = 0;
    @Zeile = ();
    $LineLen = length($Line);
    until($CharPos == $LineLen)
    {
	if(substr($Line,$CharPos,1) eq " " || substr($Line,$CharPos,1) eq "\n")
	{
                                   # hopefully, you put a space between each syllable
	    $Laenge = $CharPos - $Letzt;
	    $zeile = substr($Line,$Letzt,$Laenge); # this is one syllable
	    $Letzt = $CharPos;
	    push(@Zeile,$zeile); # get a list in order 
#to handle every syllable independently
	}
	$CharPos++;
    }
    for($i=0;$i<=$#Zeile;$i++)
    {
	if($Zeile[$i] =~ /\{\\birm/)
	{
	    $Zeile[$i] =~ s/\\birm/\\birm\\relsize\{+1\}/g; # the original Burmese font
                                                            # is a bit small 
	    $Schalter = 1; # puts the substitution routine on
	}
	elsif($Schalter > 0)
	{
	    $ZeilPos = 0;
	    $ZeilLen = length($Zeile[$i]);
	    until($ZeilPos == $ZeilLen)  # allows environments inside a Burmese one
	    {
		if(substr($Zeile[$i],$ZeilPos,1) eq "\{")
		{
		    $Schalter++;
		}
		elsif(substr($Zeile[$i],$ZeilPos,1) eq "\}")
		{
		    $Schalter--;
		}
		$ZeilPos++;
	    }
	    $Zeile[$i] =~ s/\\large/\\relsize\{\+1\}/g;#original Burmese font is small
	    $Zeile[$i] =~ s/\\Large/\\relsize\{\+2\}/g;#original Burmese font is small
	    $Zeile[$i] =~ s/\\LARGE/\\relsize\{\+3\}/g;#original Burmese font is small
	    $Zeile[$i] =~ s/\\huge/\\relsize\{\+4\}/g;#original Burmese font is small
	    $Zeile[$i] =~ s/\\Huge/\\relsize\{\+5\}/g;#original Burmese font is small
	    $Zeile[$i] =~ s/\\small/\\relsize\{\-1\}/g;#original Burmese font is small
	    $Zeile[$i] =~ s/\\footnotesize/\\relsize\{\-2\}/g;#original Burmese font is small
	    $Zeile[$i] =~ s/\\scriptsize/\\relsize\{\-3\}/g;#original Burmese font is small
	    $Zeile[$i] =~ s/\\tiny/\\relsize\{\-4\}/g;#original Burmese font is small
	    unless($Zeile[$i] =~ /\\/) # don't touch TeX commands; 
                                       ## unfortunately, arguments to TeX commands 
                                       ## will be left unchanged, too
	    {
		&tausch;  # run the substitution subroutine
	    }
################## begin of list of commands the arguments of which must be changed
	    elsif($Zeile[$i] =~ /\\textbf/) # change the arguments of TeX commands, 
		                      # but not the commands themselves
	    {
		$spalter = index($Zeile[$i],"\{"); # where the argument starts
		$antispalter = length($Zeile[$i]) - $spalter; #the length of the argument
		$Rest = substr($Zeile[$i],0,$spalter); # the TeX command
		$Zeile[$i] = substr($Zeile[$i],$spalter,$antispalter); # the argument
		&tausch; # substitute the argument by the right Burmese characters
		$Zeile[$i] = $Rest . $Zeile[$i]; # put both together again
	    }
	    elsif($Zeile[$i] =~ /\\emph/) # change the arguments of TeX commands, 
		                      # but not the commands themselves
	    {
		$spalter = index($Zeile[$i],"\{"); # where the argument starts
		$antispalter = length($Zeile[$i]) - $spalter; #the length of the argument
		$Rest = substr($Zeile[$i],0,$spalter); # the TeX command
		$Zeile[$i] = substr($Zeile[$i],$spalter,$antispalter); # the argument
		&tausch; # substitute the argument by the right Burmese characters
		$Zeile[$i] = $Rest . $Zeile[$i]; # put both together again
	    }
	    elsif($Zeile[$i] =~ /\\textsc/) # change the arguments of TeX commands, 
		                      # but not the commands themselves
	    {
		$spalter = index($Zeile[$i],"\{"); # where the argument starts
		$antispalter = length($Zeile[$i]) - $spalter; #the length of the argument
		$Rest = substr($Zeile[$i],0,$spalter); # the TeX command
		$Zeile[$i] = substr($Zeile[$i],$spalter,$antispalter); # the argument
		&tausch; # substitute the argument by the right Burmese characters
		$Zeile[$i] = $Rest . $Zeile[$i]; # put both together again
	    }
	    elsif($Zeile[$i] =~ /\\textsf/) # change the arguments of TeX commands, 
		                      # but not the commands themselves
	    {
		$spalter = index($Zeile[$i],"\{"); # where the argument starts
		$antispalter = length($Zeile[$i]) - $spalter; #the length of the argument
		$Rest = substr($Zeile[$i],0,$spalter); # the TeX command
		$Zeile[$i] = substr($Zeile[$i],$spalter,$antispalter); # the argument
		&tausch; # substitute the argument by the right Burmese characters
		$Zeile[$i] = $Rest . $Zeile[$i]; # put both together again
	    }
######################### end of repeatable list of commands the arguments of which must be changed
	}
    }
print OUT @Zeile;
print OUT "\n"; # well, everything should appear in the output unchanged now, 
                # but the words inside the Burmese environment
}
close(IN);
close(OUT);
1;


## The substitution subroutine

sub tausch{
# exchange the syllable rhyme with the correct Burmese character or character combination
# together with Character 116, the "dummy consonant"
# an 'h' signals the third tone, a '-sign the fourth tone, 
# a double vowel indicates the second tone, the first tone is unmarked 
# "N" stands for nasalized vowels
# cf. burmguide.ps

$Zeile[$i] =~ s/HNAI\'/XXX89/;
$Zeile[$i] =~ s/YWEI/XXX737/;

$Zeile[$i] =~ s/^ w/ W/;
$Zeile[$i] =~ s/^ y/ Y/;
$Zeile[$i] =~ s/aaN/XXX116XXX114XXX102\{\}/;
$Zeile[$i] =~ s/ahN/XXX116XXX114XXX102XXX59\{\}/;
$Zeile[$i] =~ s/aN/XXX116XXX114XXX102XXX104\{\}/;
$Zeile[$i] =~ s/aaiN/XXX116XXX100XXX107XXX105XXX102\{\}/;
$Zeile[$i] =~ s/aihN/XXX116XXX100XXX107XXX105XXX102XXX59\{\}/;
$Zeile[$i] =~ s/aiN/XXX116XXX100XXX107XXX105XXX102XXX104\{\}/;
$Zeile[$i] =~ s/eeiN/XXX116XXX100XXX114XXX102\{\}/;
$Zeile[$i] =~ s/eihN/XXX116XXX100XXX114XXX102XXX59\{\}/;
$Zeile[$i] =~ s/eiN/XXX116XXX100XXX114XXX102XXX104\{\}/;
$Zeile[$i] =~ s/iiN/XXX116XXX105XXX102\{\}/;
$Zeile[$i] =~ s/ihN/XXX116\{\}XXX105\{\}XXX102\{\}XXX59\{\}\{\}/;
$Zeile[$i] =~ s/iN/XXX116XXX105XXX102XXX104\{\}/;
$Zeile[$i] =~ s/oouN/XXX116XXX107XXX114XXX102\{\}/;
$Zeile[$i] =~ s/ouhN/XXX116XXX107XXX114XXX102XXX59\{\}/;
$Zeile[$i] =~ s/ouN/XXX116XXX107XXX114XXX102XXX104\{\}/;
$Zeile[$i] =~ s/aauN/XXX97XXX116XXX109XXX105XXX102\{\}/;
$Zeile[$i] =~ s/auhN/XXX97XXX116XXX109XXX105XXX102XXX59\{\}/;
$Zeile[$i] =~ s/auN/XXX97XXX116XXX109XXX105XXX102XXX104\{\}/;
$Zeile[$i] =~ s/uuN/XXX116XXX71XXX114XXX102\{\}/;
$Zeile[$i] =~ s/uhN/XXX116XXX71XXX114XXX102XXX59\{\}/;
$Zeile[$i] =~ s/uN/XXX116XXX71XXX114\{\}/;
$Zeile[$i] =~ s/ai\'/XXX116XXX100XXX107XXX117XXX102\{\}/;
$Zeile[$i] =~ s/ei\'/XXX116XXX100XXX121XXX102\{\}/;
$Zeile[$i] =~ s/ou\'/XXX116XXX107XXX121XXX102\{\}/;
$Zeile[$i] =~ s/au\'/XXX97XXX116XXX109XXX117XXX102\{\}/;
$Zeile[$i] =~ s/eei/XXX97XXX116\{\}/;
$Zeile[$i] =~ s/eih/XXX97XXX116XXX59\{\}/;
$Zeile[$i] =~ s/ei/XXX97XXX116XXX104\{\}/;
$Zeile[$i] =~ s/ee/XXX116XXX44XXX102\{\}/;
$Zeile[$i] =~ s/eh/XXX116XXX74\{\}/;
$Zeile[$i] =~ s/e\'/XXX116XXX117XXX102\{\}/;
$Zeile[$i] =~ s/ii/XXX116XXX68\{\}/;
$Zeile[$i] =~ s/ih/XXX116XXX68XXX59\{\}/;
$Zeile[$i] =~ s/i\'/XXX116XXX112XXX102\{\}/;
$Zeile[$i] =~ s/i/XXX116XXX100\{\}/;
$Zeile[$i] =~ s/e/XXX116XXX74XXX104\{\}/;
$Zeile[$i] =~ s/aa/XXX116XXX109\{\}/;
$Zeile[$i] =~ s/ah/XXX116XXX109XXX59\{\}/;
$Zeile[$i] =~ s/a\'/XXX116XXX121XXX102\{\}/;
$Zeile[$i] =~ s/a/XXX116\{\}/;
$Zeile[$i] =~ s/oh/XXX97XXX116\{\}/;
$Zeile[$i] =~ s/ouh/XXX116XXX100XXX107XXX59\{\}/;
$Zeile[$i] =~ s/ou/XXX116XXX100XXX107XXX104\{\}/;
$Zeile[$i] =~ s/oou/XXX116XXX100XXX107\{\}/;
$Zeile[$i] =~ s/oo/XXX97XXX116XXX102\{\}/;
$Zeile[$i] =~ s/o/XXX97XXX116XXX109\{\}/;
$Zeile[$i] =~ s/uu/XXX116XXX108\{\}/;
$Zeile[$i] =~ s/uh/XXX116XXX108XXX59\{\}/;
$Zeile[$i] =~ s/u\'/XXX116XXX71XXX121XXX102\{\}/;
$Zeile[$i] =~ s/u/XXX116XXX107\{\}/;
$Zeile[$i] =~ s/w/üXXX71/;
$Zeile[$i] =~ s/y/äXXX115/;

$Zeile[$i] =~ s/üXXX71XXX116/XXX116XXX71/g;
$Zeile[$i] =~ s/äXXX115XXX116/XXX116XXX115/g;
$Zeile[$i] =~ s/üXXX71XXX97XXX116/XXX97XXX116XXX71/g;
$Zeile[$i] =~ s/äXXX115XXX97XXX116/XXX97XXX116XXX115/g;


$Zeile[$i] =~ s/II/XXX84\{\}/;
$Zeile[$i] =~ s/I/XXX117XXX85XXX107\{\}/;
$Zeile[$i] =~ s/\./XXX47XXX47\{\}/;
$Zeile[$i] =~ s/,/XXX47\{\}/;
$Zeile[$i] =~ s/I2/XXX116\.\{\}/;
$Zeile[$i] =~ s/EI\'/XXX116XXX123\{\}/;
$Zeile[$i] =~ s/OO/XXX116XXX97XXX45XXX111XXX109XXX102/;
$Zeile[$i] =~ s/Oh/XXX116XXX45XXX111/;
$Zeile[$i] =~ s/O/XXX116XXX97XXX45XXX111XXX109XXX104/;
$Zeile[$i] =~ s/UU/XXX116XXX79XXX68/;
$Zeile[$i] =~ s/Uh/XXX116XXX79XXX68XXX59/;
$Zeile[$i] =~ s/U/XXX116XXX79/;


# look if there is a consonant to substitute Character 116, the "dummy consonant"
if($Zeile[$i] =~ /^ Y/){$Zeile[$i] =~ s/XXX116/XXX44/g;$Zeile[$i] =~ s/^ Y/ /g;} # oder XXX38
elsif($Zeile[$i] =~ /^ W/){$Zeile[$i] =~ s/XXX116/XXX48/g;$Zeile[$i] =~ s/^ W/ /g;}
#elsif($Zeile[$i] =~ /y/){$Zeile[$i] =~ s/y/XXX115/g;} # oder XXX106
#elsif($Zeile[$i] =~ /w/){$Zeile[$i] =~ s/w/XXX71/g;}

elsif($Zeile[$i] =~ /hw/){$Zeile[$i] =~ s/XXX116/XXX44XXX83/g;$Zeile[$i] =~ s/hw//g;}
elsif($Zeile[$i] =~ /hl/){$Zeile[$i] =~ s/XXX116/XXX118XXX83/g;$Zeile[$i] =~ s/hl//g;}
elsif($Zeile[$i] =~ /hng/){$Zeile[$i] =~ s/XXX116/XXX105XXX83/g;$Zeile[$i] =~ s/hng//g;}
elsif($Zeile[$i] =~ /hny/){$Zeile[$i] =~ s/XXX116/XXX110XXX83/g;$Zeile[$i] =~ s/hny//g;}
elsif($Zeile[$i] =~ /hn/){$Zeile[$i] =~ s/XXX116/XXX101XXX83/g;$Zeile[$i] =~ s/hn//g;}
elsif($Zeile[$i] =~ /hm/){$Zeile[$i] =~ s/XXX116/XXX114XXX83/g;$Zeile[$i] =~ s/hm//g;}
elsif($Zeile[$i] =~ /^h/){$Zeile[$i] =~ s/XXX116/XXX91/g;$Zeile[$i] =~ s/^h//g;}
elsif($Zeile[$i] =~ /ph/){$Zeile[$i] =~ s/XXX116/XXX122/g;$Zeile[$i] =~ s/ph//g;}
elsif($Zeile[$i] =~ /p/){$Zeile[$i] =~ s/XXX116/XXX121/g;$Zeile[$i] =~ s/p//g;}
elsif($Zeile[$i] =~ /b/){$Zeile[$i] =~ s/XXX116/XXX65/g;$Zeile[$i] =~ s/b//g;} # oder XXX98
#elsif($Zeile[$i] =~ /t2/){$Zeile[$i] =~ s/XXX116/XXX64/g;$Zeile[$i] =~ s/t2//g;}
#elsif($Zeile[$i] =~ /d2/){$Zeile[$i] =~ s/XXX116/XXX89/g;$Zeile[$i] =~ s/d2//g;}
elsif($Zeile[$i] =~ /g2/){$Zeile[$i] =~ s/XXX116/XXX67/g;$Zeile[$i] =~ s/g2//g;}
elsif($Zeile[$i] =~ /n2/){$Zeile[$i] =~ s/XXX116/XXX37/g;$Zeile[$i] =~ s/n2//g;}
elsif($Zeile[$i] =~ /ny2/){$Zeile[$i] =~ s/XXX116/XXX79/g;$Zeile[$i] =~ s/ny2//g;}
elsif($Zeile[$i] =~ /th/){$Zeile[$i] =~ s/XXX116/XXX120/g;$Zeile[$i] =~ s/th//g;} # oder XXX88
elsif($Zeile[$i] =~ /t/){$Zeile[$i] =~ s/XXX116/XXX119/g;$Zeile[$i] =~ s/t//g;}
elsif($Zeile[$i] =~ /d/){$Zeile[$i] =~ s/XXX116/XXX34/g;$Zeile[$i] =~ s/d//g;} # oder gibts nicht
elsif($Zeile[$i] =~ /kh/){$Zeile[$i] =~ s/XXX116/XXX99/g;$Zeile[$i] =~ s/kh//g;}
elsif($Zeile[$i] =~ /k/){$Zeile[$i] =~ s/XXX116/XXX117/g;$Zeile[$i] =~ s/k//g;}
elsif($Zeile[$i] =~ /g/){$Zeile[$i] =~ s/XXX116/XXX42/g;$Zeile[$i] =~ s/g//g;}
elsif($Zeile[$i] =~ /T/){$Zeile[$i] =~ s/XXX116/XXX111/g;$Zeile[$i] =~ s/T//g;}
elsif($Zeile[$i] =~ /sh/){$Zeile[$i] =~ s/XXX116/XXX113/g;$Zeile[$i] =~ s/sh//g;}
elsif($Zeile[$i] =~ /s/){$Zeile[$i] =~ s/XXX116/XXX112/g;$Zeile[$i] =~ s/s//g;}
elsif($Zeile[$i] =~ /z/){$Zeile[$i] =~ s/XXX116/XXX90/g;$Zeile[$i] =~ s/z//g;} # oder XXX112XXX115
elsif($Zeile[$i] =~ /Sw/){$Zeile[$i] =~ s/XXX116/XXX38XXX36/g;$Zeile[$i] =~ s/Sw//g;}
elsif($Zeile[$i] =~ /S/){$Zeile[$i] =~ s/XXX116/XXX38XXX83/g;$Zeile[$i] =~ s/S//g;}
elsif($Zeile[$i] =~ /ch/){$Zeile[$i] =~ s/XXX116/XXX99XXX115/g;$Zeile[$i] =~ s/ch//g;} #oder XXX99XXX106
elsif($Zeile[$i] =~ /c/){$Zeile[$i] =~ s/XXX116/XXX117XXX115/g;$Zeile[$i] =~ s/c//g;} #oder XXX117XXX125
elsif($Zeile[$i] =~ /j/){$Zeile[$i] =~ s/XXX116/XXX42XXX115/g;$Zeile[$i] =~ s/j//g;} #oder XXX42XXX106
elsif($Zeile[$i] =~ /m/){$Zeile[$i] =~ s/XXX116/XXX114/g;$Zeile[$i] =~ s/m//g;}
elsif($Zeile[$i] =~ /ny/){$Zeile[$i] =~ s/XXX116/XXX110/g;$Zeile[$i] =~ s/ny//g;}
elsif($Zeile[$i] =~ /ng/){$Zeile[$i] =~ s/XXX116/XXX105/g;$Zeile[$i] =~ s/ng//g;}
elsif($Zeile[$i] =~ /n/){$Zeile[$i] =~ s/XXX116/XXX101/g;$Zeile[$i] =~ s/n//g;}
elsif($Zeile[$i] =~ /l/){$Zeile[$i] =~ s/XXX116/XXX118/g;$Zeile[$i] =~ s/l//g;}
elsif($Zeile[$i] =~ /I/ || $Zeile[$i] =~ /O/ || $Zeile[$i] =~ /U/)
   {$Zeile[$i] =~ s/XXX116//g;}

$Zeile[$i] =~ s/XXX/\\char/g;
}
#EOF
