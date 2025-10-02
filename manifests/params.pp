# @api private
class mock::params {

  case $facts['os']['family'] {
    'RedHat': {
      $group_name   = 'mock'
      $package_name = 'mock'
    }

    default: {
      fail("Unsupported osfamily: ${facts['os']['family']}, module ${module_name} only support osfamily RedHat")
    }
  }

}
