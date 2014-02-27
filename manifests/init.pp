# == Class: kiosk
#
# Make device boot into kiosk mode starting a browser in fullscreen
# opening a given url.
#
# === Examples
#
#  class { 'kiosk':
#    url => 'http://example.com',
#  }
#
# === Authors
#
# Christian Haeusler <christian.haeusler@md-systems.ch>
#
# === Copyright
#
# Copyright 2013 MD Systems.
#
class kiosk (
  $url
) {
  package { 'chromium':
    ensure => 'present',
  }
  package { 'unclutter':
    ensure => 'present',
  }
  file { 'kiosk_autostart':
    ensure  => present,
    path    => '/etc/xdg/lxsession/LXDE/autostart',
    content => template('kiosk/autostart.erb'),
  }
  service { 'lightdm':
    ensure  => running,
  }
  Package['unclutter']->Package['chromium']->File['kiosk_autostart']~>Service['lightdm']
}
