require 'json'

version = '1.6.2'

a = {}
a['name'] = 'unbound'
a['version'] = version
a['license'] = 'BSD'
a['commands'] = [
  <<~EOF
  yum install -y wget gcc make openssl-devel expat-devel python-devel swig libevent-devel
  wget https://unbound.net/downloads/unbound-#{version}.tar.gz
  tar xvfz unbound-#{version}.tar.gz
  cd unbound-#{version}
  ./configure --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-libevent --with-pthreads --with-ssl --disable-rpath --with-conf-file=/etc/unbound/unbound.conf --with-pidfile=/var/run/unbound/unbound.pid --with-pythonmodule --with-pyunbound --enable-sha2 --disable-gost --enable-ecdsa --with-rootkey-file=/var/lib/unbound/root.key
  make && make install
  cp -v /tmp/files/unbound/unbound.conf /etc/unbound/unbound.conf
  mkdir -vp /etc/unbound/conf.d
  EOF
]
a['depends'] = []
a['cwd'] = ''
a['env'] = {}
a['outputs'] = %w(deb rpm)
a['scripts'] = {
  'after-install' => 'files/scripts/after-install.sh',
}
a['package_files'] = {
  '/tmp/files' => '/tmp/unbound',
  '/etc/unbound' => '/etc/unbound',
  '/usr/sbin/unbound' => '/usr/sbin/unbound',
  '/usr/sbin/unbound-anchor' => '/usr/sbin/unbound-anchor',
  '/usr/sbin/unbound-checkconf' => '/usr/sbin/unbound-checkconf',
  '/usr/sbin/unbound-control' => '/usr/sbin/unbound-control',
  '/usr/sbin/unbound-control-setup' => '/usr/sbin/unbound-control-setup',
  '/usr/sbin/unbound-host' => '/usr/sbin/unbound-host',
  '/usr/lib64/libunbound.so*' => '/usr/lib64/',
}
a['build_distro'] = 'centos'
a['build_distro_version'] = '7'

File.write("#{__dir__}/packyao.json", JSON.pretty_generate(a))
