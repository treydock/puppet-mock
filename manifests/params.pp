# @api private
class mock::params {

  case $::osfamily {
    'RedHat': {
      $group_name   = 'mock'
      $package_name = 'mock'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
