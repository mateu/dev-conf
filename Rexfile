use Rex;
use Rex::Commands::Pkg;
use Rex::Commands::Host;

user "hunter";
private_key "~/.ssh/id_rsa";
public_key  "~/.ssh/id_rsa.pub";
sudo TRUE;

group workstation => "bcn";

task "install", group => "workstation", sub {

  install package => [
    "build-essential",
    "curl",
    "libexpat1-dev",
    "libnet-ssh2-perl",
    "carton",
    "tmux",
    "screen",
    "irssi",
    "git",
    "openssh-server",
    "keychain",
    "emacs24-nox",
    "openjdk-8-jre-headless",
    "chromium-browser",
    "gkrellm",
  ];

};

task "remove", group => "workstation", sub {
   remove package => [qw/screen irssi/];
};

task "hosts", group => "workstation", sub {
  file "/etc/hosts",
    content => template("template/hosts");
};
task "uptime", group => "workstation", sub {
  my $output = run "uptime";
  say $output;
};

