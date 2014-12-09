use Rex;
use Rex::Commands::Pkg;
use Rex::Commands::Host;

user "hunter";
private_key "~/.ssh/id_rsa";
public_key  "~/.ssh/id_rsa.pub";
sudo TRUE;

group workstation => "localhost";

task "install", group => "workstation", sub {

  install package => [
    "build-essential",
    "curl",
    "vim",
    "perl-doc",
    "perltidy",
    "libssl-dev",
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
    "whois",
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

task "es_install", group => "workstation", sub {
  my $key_add = run "wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -";
  repository "add" => "elasticsearch",
     url      => "http://packages.elasticsearch.org/elasticsearch/1.4/debian",
     distro    => "stable",
     repository => "main";
  update_package_db;
  install package => [ "elasticsearch",];
  my $rc_setting = run "update-rc.d elasticsearch defaults 95 10";
  my $es_start = run "/etc/init.d/elasticsearch start";
};

task "add_es_inquisitor", group => "workstation", sub {
  run "add-inquisitor-plugin",
    command => "bin/plugin -install polyfractal/elasticsearch-inquisitor",
    cwd     => "/usr/share/elasticsearch";
};
