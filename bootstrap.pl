#!/usr/bin/env perl
use 5.010;

my $out = `sudo apt-get install git-core curl build-essential libssl-dev libexpat1-dev libnet-ssh2-perl openssh-server`;
say $out;

if (not eval
{
  require Rex;
  Rex->import();
  1;
}) {
    my $out = `curl -L https://get.rexify.org | perl - --sudo -n Rex`;
    say $out;
}
else { say 'Rex already installed' }


$out = `mkdir -p -- /home/hunter/dev`;
say $out;

my $dev_conf = '/home/hunter/dev/dev-conf'; 
if (not -d $dev_conf) {
    my $out =`git clone git@github.com:mateu/dev-conf.git $dev_conf`;
    say $out;
}
else { say 'dev-conf already cloned' }

say "\nDONE\n";
