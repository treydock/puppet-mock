# == Class: mock
#
# See README.md for more details.
#
class mock (
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $manage_group = true,
  Boolean $manage_epel = true,
  Integer $group_gid = 135,
  String $group_name = $mock::params::group_name,
  String $package_name = $mock::params::package_name,
) inherits mock::params {

  if $manage_epel {
    include epel
    Class['epel'] -> Package['mock']
  }

  if $manage_group {
    group { 'mock':
      ensure => $ensure,
      name   => $group_name,
      gid    => $group_gid,
      before => Package['mock'],
    }
  }

  package { 'mock':
    ensure => $ensure,
    name   => $package_name,
  }

}
