# puppet-mock

[![Build Status](https://travis-ci.org/treydock/puppet-mock.png)](https://travis-ci.org/treydock/puppet-mock)

####Table of Contents

1. [Overview - What is the mock module?](#overview)
2. [Usage - Configuration and customization options](#usage)
    * [Class: mock](#class-mock)
3. [Development - Guide for contributing to the module](#development)
    * [Testing - Testing your configuration](#testing)
4. [Further Information](#further-information)

## Overview

This module manages the basics to begin using mock to rebuild RPMs.

## Usage

### Class: `mock`

By default this class performs the following actions.

* Includes the `epel` class
* Creates the `mock` group
* Installs the `mock` package

Define the class with default parameters.

    class { 'mock': }


Disable management of the mock group.


    class { 'mock':
      manage_group  => false,
    }

To remove the mock group and the mock package

    class { 'mock':
      ensure  => 'absent',
    }

#### Parameters for `mock` class

#####`ensure`

Sets the `ensure` parameter for the classes' managed resources (defaults to `'present'`).

#####`manage_group`

Boolean that determines if the group resource is managed by this module (defaults to `true`).

#####`group_gid`

Sets the mock group's GID (defaults to `'135'`).

#####`group_name`

Name of the mock group (defaults to 'mock').

#####`package_name`

Name of the mock package (defaults to 'mock').

## Limitations

This module has been built on and tested against Puppet 2.7 and higher.

This module has been tested on:

* CentOS 5/6

## Development

### Testing

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake test

If you have Vagrant >= 1.2.0 installed you can run acceptance tests

    bundle exec rake acceptance

## Further Information

* https://fedoraproject.org/wiki/Projects/Mock
