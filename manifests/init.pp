# == Class: mock
#
# See README.md for more details.
#
class mock (
  $ensure = 'present',
  $manage_group = true,
  $manage_epel = true,
  $group_gid = '135',
  $group_name = $mock::params::group_name,
  $package_name = $mock::params::package_name,
) inherits mock::params {

  validate_re($ensure, [ '^present', '^absent' ])
  validate_bool($manage_group)
  validate_bool($manage_epel)

  if $manage_epel {
    include epel
    Package['mock'] -> Yumrepo['epel']
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
    ensure  => $ensure,
    name    => $package_name,
  }

}
