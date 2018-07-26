# == Class: mock
#
# See README.md for more details.
#
class mock (
  Enum['present', 'absent'] $ensure = 'present',
  Boolean $manage_group = true,
  Boolean $manage_epel = true,
  Integer $group_gid = 135,
  Array $group_members = [],
  String $group_name = $mock::params::group_name,
  String $package_name = $mock::params::package_name,
) inherits mock::params {

  if $manage_epel {
    include epel
    Class['epel'] -> Package['mock']
  }

  if $manage_group {
    group { 'mock':
      ensure     => $ensure,
      name       => $group_name,
      gid        => $group_gid,
      forcelocal => true,
      before     => Package['mock'],
    }
    $group_member_require = Group['mock']
  } else {
    $group_member_require = undef
  }

  $_group_members = join(sort($group_members), ',')
  exec { 'manage-mock-group-members':
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    command => "lgroupmod -m `egrep '^mock:' /etc/group | cut -d: -f4` ${group_name} ; lgroupmod -M ${_group_members} ${group_name}",
    unless  => "egrep '^${group_name}:' /etc/group | cut -d: -f4 | tr ',' '\\n' | sort | paste -sd, | egrep '^${_group_members}$'",
    require => $group_member_require,
  }

  package { 'mock':
    ensure => $ensure,
    name   => $package_name,
  }

}
