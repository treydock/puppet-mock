# puppet-mock

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/mock.svg)](https://forge.puppetlabs.com/treydock/mock)
[![Build Status](https://travis-ci.org/treydock/puppet-mock.png)](https://travis-ci.org/treydock/puppet-mock)

#### Table of Contents

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

Add users to mock group

    class { 'mock':
      group_members => ['user1', 'user2'],
    }

Disable management of the mock group.


    class { 'mock':
      manage_group  => false,
    }

To remove the mock group and the mock package

    class { 'mock':
      ensure  => 'absent',
    }

## Reference

[http://treydock.github.io/puppet-mock/](http://treydock.github.io/puppet-mock/)

## Limitations

This module has been built on and tested against Puppet 4.7 and higher.

This module has been tested on:

* CentOS 6/7

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

    bundle exec rake beaker

## Further Information

* https://fedoraproject.org/wiki/Projects/Mock
