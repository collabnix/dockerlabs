# Running Minikube & Docker for Mac side by side

```
Ajeets-MacBook-Air:~ ajeetraina$ brew update && brew install kubectl && brew cask install minikube
Updated 2 taps (homebrew/core, linuxkit/linuxkit).
==> New Formulae
amber                        elektra                      libtomcrypt                  spades
auditbeat                    field3d                      mariadb-connector-odbc       sratoolkit
augustus                     glances                      mmseqs2                      stress-ng
bamtools                     go-statik                    monero                       telnetd
bcftools                     gox                          mpir                         tmux-xpanes
bedops                       hlint                        nyx                          tnftp
bioawk                       hmmer                        opencascade                  tnftpd
blast                        jdupes                       orocos-kdl                   travis
bwa                          kallisto                     plank                        vcftools
container-diff               kumo                         samtools                     vis
cp2k                         lammps                       seqtk                        visp
darksky-weather              libccd                       sickle                       yq
diamond                      libjwt                       skafos                       zig
==> Updated Formulae
asciinema ✔                           graphicsmagick                        pcsc-lite
awscli ✔                              grc                                   pdal
gdbm ✔                                grib-api                              pdf2htmlex
glib ✔                                gromacs                               pdftoedn
gnutls ✔                              gron                                  pdns
go ✔                                  groonga                               pdnsrec
libtasn1 ✔                            grpc                                  pegtl
linuxkit/linuxkit/linuxkit ✔          gsoap                                 percona-server
openssl@1.1 ✔                         gspell                                percona-toolkit
python3 ✔                             gst-plugins-bad                       percona-xtrabackup
sqlite ✔                              gst-plugins-base                      pex
wget ✔                                gst-python                            pg_top
abcm2ps                               gtk+                                  pgbouncer
abcmidi                               gtkspell3                             pgcli
abyss                                 guile                                 pgloader
ack                                   guile@2.0                             pgplot
acmetool                              gutenberg                             pgpool-ii
acpica                                gwt                                   pgrouting
agda                                  gwyddion                              pianod
algernon                              gxml                                  picard-tools
amazon-ecs-cli                        gzip                                  pick
angband                               hadolint                              picocom
angular-cli                           haproxy                               pigz
ansible                               harfbuzz                              pilosa
ansible-lint                          hashpump                              pipenv
antigen                               haskell-stack                         pius
apache-arrow                          haste-client                          pjproject
apache-opennlp                        hdf5                                  planck
apache-spark                          hdf5@1.8                              plantuml
apibuilder-cli                        heartbeat                             platformio
apktool                               henplus                               plplot
apm-server                            heroku                                pmd
app-engine-go-64                      hexgui                                pngquant
app-engine-java                       hg-fast-export                        poco
arangodb                              hg-flow                               pod2man
argon2                                hh                                    ponyc
argyll-cms                            highlight                             ponysay
armadillo                             hledger                               postgis
armor                                 homebank                              postgres-xc
arpack                                htop                                  postgresql
artifactory                           htslib                                postgresql@9.4
asdf                                  http-server                           postgresql@9.5
astyle                                httpd                                 postgresql@9.6
ats2-postiats                         httpie                                postgrest
augeas                                hugo                                  povray
autogen                               hwloc                                 pre-commit
aws-elasticbeanstalk                  hydra                                 presto
aws-sdk-cpp                           hyperscan                             prometheus
azure-cli                             hypre                                 proof-general
babl                                  ib                                    protobuf
backupninja                           ibex                                  protobuf@2.5
bam                                   ice                                   pspg
bandcamp-dl                           idnits                                psqlodbc
baresip                               idris                                 pure-ftpd
bartycrouch                           igv                                   pushpin
basex                                 imagemagick                           pwntools
bash-git-prompt                       imagemagick@6                         py3cairo
bash-preexec                          imagesnap                             pybind11
bash-snippets                         immortal                              pyenv
bazel                                 innotop                               pygobject
bdw-gc                                inspircd                              pygobject3
bear                                  io                                    pypy
beast                                 ipython                               pypy3
bench                                 ipython@5                             pyqt
bento4                                iron-functions                        python
bettercap                             irssi                                 pytouhou
betty                                 iso-codes                             qca
binaryen                              jags                                  qd
bind                                  jenkins                               qmmp
binwalk                               jenkins-job-builder                   qpdf
biogeme                               jenkins-lts                           qpid-proton
bit                                   jetty                                 qrupdate
bitcoin                               jetty-runner                          qscintilla2
bitrise                               jfrog-cli-go                          qt
blackbox                              jhiccup                               qt@5.7
blastem                               jhipster                              quex
boost                                 jing-trang                            quicktype
boost-bcp                             joe                                   r
boost-build                           joplin                                rabbitmq
boost-mpi                             json-fortran                          radamsa
boost-python                          jsoncpp                               radare2
boost-python@1.59                     jsvc                                  rancher-cli
boost@1.55                            juju                                  ratfor
boost@1.57                            juju-wait                             rbenv-aliases
boost@1.59                            jump                                  rbenv-binstubs
boost@1.60                            just                                  rbenv-bundle-exec
bork                                  kafka                                 rbenv-bundler
botan                                 karn                                  rbenv-bundler-ruby-version
bowtie2                               kedge                                 rbenv-chefdk
braid                                 keepassc                              rbenv-communal-gems
bsponmpi                              khal                                  rbenv-ctags
bubbros                               khard                                 rbenv-default-gems
buku                                  kibana                                rbenv-gemset
bzt                                   kitchen-sync                          rbenv-use
cake                                  kite                                  rbenv-vars
calabash                              knot                                  rbenv-whatis
cargo-completion                      knot-resolver                         rclone
cask                                  kobalt                                re2
cayley                                kompose                               rebar@3
ccache                                konoha                                recutils
ccm                                   kontena                               redis
ceres-solver                          kotlin                                redland
certbot                               kpcli                                 restic
cfengine                              kubeless                              rex
cgal                                  kubernetes-cli                        rgbds
cgrep                                 kubernetes-helm                       riemann
chakra                                languagetool                          rocksdb
chamber                               lapack                                rom-tools
charm-tools                           latexila                              root
cheat                                 lbdb                                  roswell
check_postgres                        lcm                                   rpm
checkstyle                            ldc                                   rtags
chisel                                ldns                                  rtv
chromaprint                           leaps                                 ruby
chromedriver                          ledger                                ruby-build
chronograf                            lensfun                               ruby@1.9
chuck                                 leptonica                             ruby@2.0
cimg                                  lgogdownloader                        ruby@2.1
citus                                 libatomic_ops                         ruby@2.2
clamav                                libbitcoin                            ruby@2.3
clipper                               libbitcoin-blockchain                 rust
clojure                               libbitcoin-database                   rustup-init
cloog                                 libbitcoin-explorer                   s-search
closure-compiler                      libbitcoin-node                       s6
cmake                                 libbitcoin-server                     sagittarius-scheme
cmark                                 libcddb                               saldl
cmark-gfm                             libcdio                               sassc
cockroach                             libcds                                sbcl
cocoapods                             libconfig                             sbt
coffeescript                          libcouchbase                          scalapack
collectd                              libdvdcss                             sccache
collector-sidecar                     libdvdnav                             scipy
compcert                              libdvdread                            scummvm
conan                                 libebur128                            scummvm-tools
conjure-up                            libfabric                             selecta
consul                                libgetdata                            serialosc
convox                                libgig                                serveit
corebird                              libgit2-glib                          sfcgal
coreutils                             libgosu                               shadowsocks-libev
corsixth                              libhttpseverywhere                    shairport-sync
cppad                                 libjson-rpc-cpp                       shfmt
cppcheck                              liblunar                              shmcat
cppcms                                libmagic                              shocco
cracklib                              libmaxminddb                          shunit2
creduce                               libmonome                             shyaml
cromwell                              libmpc                                silk
crosstool-ng                          libmspub                              simgrid
crowdin                               libpagemaker                          sip
cryfs                                 libphonenumber                        sjk
cryptopp                              libpqxx                               smlnj
crystal-icr                           libpst                                snakemake
crystal-lang                          libqalculate                          snapcraft
csvkit                                libraw                                snappy
csvtomd                               libre                                 snappystream
ctop                                  librealsense                          snapraid
cucumber-cpp                          libressl                              sngrep
curl                                  librsvg                               snort
czmq                                  libsass                               socat
dar                                   libsigsegv                            solr
datetime-fortran                      libsoup                               sonarqube
datomic                               libstfl                               sops
davmail                               libtensorflow                         source-highlight
dbhash                                libtiff                               sourcery
dcm2niix                              libtorrent-rasterbar                  spdlog
dcos-cli                              libu2f-server                         speech-tools
ddgr                                  libuv                                 sphinx
debianutils                           libvirt                               sphinx-doc
dehydrated                            libvoikko                             spigot
dep                                   libvpx                                spin
dependency-check                      libxc                                 sql-translator
devd                                  libzdb                                sqlcipher
dhall-json                            link-grammar                          sqldiff
diff-so-fancy                         linkerd                               sqlite-analyzer
diffoscope                            liquigraph                            sqlmap
digdag                                little-cms                            squashfs
ditaa                                 llnode                                ssh-audit
django-completion                     llvm                                  sslh
dlib                                  llvm@3.9                              sslscan
dmd                                   llvm@4                                sslsplit
dnscrypt-proxy                        logstash                              sslyze
docfx                                 logtalk                               statik
docker                                lwtools                               streamlink
docker-completion                     lxc                                   stubby
docker-compose                        lynis                                 subversion
docker-compose-completion             lysp                                  subversion@1.8
docker-gen                            lz4                                   suite-sparse
docker-machine-nfs                    macosvpn                              sundials
doxygen                               macvim                                superlu
doxymacs                              magic-wormhole                        svgcleaner
dpkg                                  mame                                  svtplay-dl
dscanner                              mapnik                                swagger-codegen
dssim                                 mariadb                               swi-prolog
dub                                   mariadb-connector-c                   swiftformat
duck                                  mariadb@10.1                          swiftlint
dungeon                               mat                                   sword
duplicity                             mdp                                   sync_gateway
e2fsprogs                             media-info                            syncthing
ecl                                   mediaconch                            sysbench
ejabberd                              memcached                             sysdig
elasticsearch                         menhir                                taisei
elixir                                mercurial                             taktuk
elvish                                meson                                 talloc
emscripten                            mesos                                 tcl-tk
encfs                                 metaproxy                             tclap
enchant                               metricbeat                            telegraf
entr                                  micro                                 teleport
envconsul                             micropython                           termius
ephemeralpg                           mikutter                              terraform
eralchemy                             miller                                terraform_landscape
erlang                                mingw-w64                             terragrunt
etcd                                  minio-mc                              texmath
etsh                                  miniupnpc                             thefuck
exim                                  minizinc                              thrift
exomizer                              mitmproxy                             thrift@0.9
exploitdb                             mksh                                  tig
faas-cli                              mkvtoolnix                            tile38
fabio                                 mlt                                   tin
fades                                 moco                                  tintin
fail2ban                              modules                               tippecanoe
fb-client                             molecule                              tnef
fbi-servefiles                        monetdb                               todoman
fd                                    mongo-c-driver                        tokei
fdclone                               mongodb                               tomcat
fdroidserver                          monitoring-plugins                    tomcat-native
feh                                   moreutils                             tor
fftw                                  mp3gain                               tracebox
fibjs                                 mpd                                   traefik
filebeat                              mpfi                                  trafficserver
fio                                   mpfr                                  transmission
firebase-cli                          mpich                                 ttf2eot
fish                                  mplayershell                          ttfautohint
flatcc                                mpv                                   ttyd
flow                                  mr                                    ttyrec
fluent-bit                            mruby                                 twarc
fluid-synth                           mu                                    twoping
fmt                                   mutt                                  twtxt
fn                                    mycli                                 txr
fobis                                 mypy                                  u-boot-tools
folly                                 mysql                                 uhd
fonttools                             mysql++                               unbound
format-udf                            mysql-connector-c++                   unixodbc
fox                                   mysql-sandbox                         unoconv
freeciv                               mysql@5.5                             urh
freeswitch                            mysql@5.6                             urweb
freetds                               mytop                                 v8
freetype                              nagios-plugins                        vala
frugal                                nano                                  vapoursynth
fwup                                  nats-streaming-server                 vault
gammu                                 ncmpcpp                               vcdimager
gauge                                 nco                                   vdirsyncer
gawk                                  ncurses                               veclibfort
gcc                                   neko                                  verilator
gcc@4.9                               nesc                                  vim
gcc@5                                 net-snmp                              vim@7.4
gcc@6                                 netcdf                                vips
gdal                                  newsboat                              voltdb
gdcm                                  nghttp2                               vte
gearman                               ngrep                                 vtk
gedit                                 nifi                                  vultr
geeqie                                nikto                                 w-calc
gegl                                  nnn                                   w3m
geoip                                 node                                  watson
geoserver                             node-build                            weboob
get-flash-videos                      node@6                                websocketd
get_iplayer                           node@8                                weechat
getdns                                nomad                                 wesnoth
getmail                               noti                                  whatmp3
gexiv2                                notmuch                               whohas
ghi                                   nq                                    whois
gifsicle                              nrpe                                  widelands
gifski                                nspr                                  wiggle
gimme                                 nss                                   wine
gist                                  numpy                                 winetricks
git                                   nuxeo                                 wireguard-tools
git-annex                             nvc                                   wireshark
git-cinnabar                          octave                                wolfssl
git-cola                              offlineimap                           wpscan
git-ftp                               ola                                   writerperfect
git-integration                       oniguruma                             wrk
git-remote-hg                         onioncat                              wtf
git-secret                            ooniprobe                             wwwoffle
git-town                              open-babel                            wxpython
gitbucket                             open-mpi                              x3270
gitg                                  openblas                              xapian
github-keygen                         opencoarrays                          xcenv
gitlab-runner                         opencolorio                           xml-tooling-c
gjs                                   opencv                                xmrig
gmime                                 opencv@2                              xonsh
gmsh                                  openrtsp                              xtensor
gmt                                   openshift-cli                         xvid
gmt@4                                 openttd                               xxhash
gnome-builder                         orc-tools                             yaf
gnome-doc-utils                       oscats                                yara
gnome-recipes                         osm2pgrouting                         yaze-ag
gnu-smalltalk                         osm2pgsql                             yeti
gnumeric                              osquery                               ykpers
gnupg                                 osrm-backend                          yle-dl
gnupg@2.0                             overmind                              you-get
gnuradio                              owfs                                  youtube-dl
gobuster                              packetbeat                            z3
godep                                 packmol                               zabbix
goenv                                 paket                                 zero-install
goffice                               pandoc                                zile
gollum                                pandoc-citeproc                       zimg
gom                                   pandoc-crossref                       znc
goofys                                par2                                  zookeeper
googler                               parallel                              zplug
gopass                                pari                                  zpython
gpg-agent                             pass                                  zsh
gradle                                passpie                               zsh-lovers
gradle-completion                     pcl                                   zstd
==> Renamed Formulae
camlistore -> perkeep
==> Deleted Formulae
antlr@3                               gst-plugins-base@0.10                 mongodb@2.6
apache-spark@1.5                      gst-plugins-good@0.10                 moodbar
apache-spark@1.6                      gst-plugins-ugly@0.10                 mpfr@2
autoconf@2.64                         gstreamer@0.10                        mvptree
automake@1.12                         influxdb@0.8                          open-mpi@1.6
azure-cli@1                           isl@0.11                              otto
bazel@0.2                             isl@0.12                              pcap_dnsproxy
clang-format@3.8                      isl@0.14                              percona-server@5.5
cloog@0.15                            jetty@8                               perl@5.14
cloudbees-sdk                         jpeg@6                                pond
docker@1.11                           juju@1.25                             ponscripter-sekai
docker@1.71                           kubernetes-cli@1.3                    ppl@0.11
eigen@3.2                             laszip@2                              redis@2.6
gcc@4.6                               ledger@2.6                            selenium-server-standalone@2.45
gcc@4.7                               libmpc@0.8                            srtp@1.6
gcc@4.8                               libpng@1.2                            stklos
glfw@2                                libpqxx@3                             swig@2
gmp@4                                 libxml2@2.7                           talk-filters
go@1.5                                litmus                                unison@2.40
grails@2.5                            logstash@2.4                          zeromq@3.2
gsl@1                                 logstash@5.6                          zeromq@4.0
gst-plugins-bad@0.10                  mg3a                                  zeromq@4.1
==> Downloading https://homebrew.bintray.com/bottles/kubernetes-cli-1.9.2.high_sierra.bottle.tar.gz
######################################################################## 100.0%
==> Pouring kubernetes-cli-1.9.2.high_sierra.bottle.tar.gz
==> Caveats
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> Summary
🍺  /usr/local/Cellar/kubernetes-cli/1.9.2: 172 files, 65.3MB
==> Tapping caskroom/cask
Cloning into '/usr/local/Homebrew/Library/Taps/caskroom/homebrew-cask'...
remote: Counting objects: 4009, done.
remote: Compressing objects: 100% (3987/3987), done.
remote: Total 4009 (delta 36), reused 510 (delta 18), pack-reused 0
Receiving objects: 100% (4009/4009), 1.37 MiB | 751.00 KiB/s, done.
Resolving deltas: 100% (36/36), done.
Tapped 0 formulae (4,018 files, 4.3MB)
==> Creating Caskroom at /usr/local/Caskroom
==> We'll set permissions properly so we won't need sudo in the future
Password:
==> Satisfying dependencies
All Formula dependencies satisfied.
==> Downloading https://storage.googleapis.com/minikube/releases/v0.25.0/minikube-darwin-amd64
######################################################################## 100.0%
==> Verifying checksum for Cask minikube
==> Installing Cask minikube
==> Linking Binary 'minikube-darwin-amd64' to '/usr/local/bin/minikube'.
🍺  minikube was successfully installed!
```
