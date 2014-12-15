use Rex;
use Rex::Commands::Pkg;
use Rex::Commands::Host;
use Rex::Commands::SCM;
use Rex::Commands::Fs;

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
    "virtualbox",
    "vagrant",
    "molly-guard",
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
  file "/etc/elasticsearch/elasticsearch.yml",
    content => template("template/elasticsearch.yml"),
    on_change => sub { service elasticsearch => "restart"; };
  my $rc_setting = run "update-rc.d elasticsearch defaults 95 10";
  my $es_start = run "/etc/init.d/elasticsearch start";
};

task "add_es_inquisitor", group => "workstation", sub {
  run "add-inquisitor-plugin",
    command => "bin/plugin -install polyfractal/elasticsearch-inquisitor",
    cwd     => "/usr/share/elasticsearch";
};
task "add_es_kopf", group => "workstation", sub {
  run "add-kopf-plugin",
    command => "bin/plugin -install lmenezes/elasticsearch-kopf/master",
    cwd     => "/usr/share/elasticsearch";
};

task "make_dirs", group => "workstation", sub {
   file "~/bin",
     ensure => "directory",
     owner  => "hunter",
     group  => "hunter";
   file "~/dev",
     ensure => "directory",
     owner  => "hunter",
     group  => "hunter";
   file "~/.irssi/scripts/autorun",
     ensure => "directory",
     owner  => "hunter",
     group  => "hunter";
   file "~/.config/autostart",
     ensure => "directory",
     owner  => "hunter",
     group  => "hunter";
};


task "install_irssi_scripts", sub {
  # Make sure dev/ for repos and bin/ for scripts exist
  make_dirs();

  # notifications
  do_task "install_libnotify";
  set repository => "irssi-libnotify",
    url => "https://code.google.com/p/irssi-libnotify/";
  checkout "irssi-libnotify",
    path => "~/dev/irssi-libnotify";
  cp("~/dev/irssi-libnotify/irssi-notifier.sh", "~/bin/");
  cp("~/dev/irssi-libnotify/notify-listener.py", "~/bin/");
  file "~/.config/autostart/notify-listener.py.desktop",
    content => template("template/notify-listener.py.desktop");
  cp("~/dev/irssi-libnotify/notify.pl", "~/.irssi/scripts/");
  ln("~/.irssi/scripts/notify.pl", "~/.irssi/scripts/autorun/");
  # window list
  file "~/.irssi/scripts/adv_windowlist.pl",
    content => template("template/adv_windowlist.pl");
  ln("~/.irssi/scripts/adv_windowlist.pl", "~/.irssi/scripts/autorun/");
  
  # terminal startup of tmux and irssi
  file "~/bin/tunnel.sh",
    mode => 755,
    content => template("template/tunnel.sh");
  file "~/bin/launch-terminal.sh",
    mode => 755,
    content => template("template/launch-terminal.sh");
  file "~/.config/autostart/terminal.desktop",
    content => template("template/terminal.desktop");
};

task "install_libnotify", group => "workstation", sub {
  install package => [
    "system-tools-backends",
    "libnotify4",
  ]
};
