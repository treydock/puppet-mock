require 'spec_helper'

describe 'mock' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      it { should create_class('mock') }
      it { should contain_class('mock::params') }

      it { should contain_class('epel').that_comes_before('Package[mock]') }

      it do
        should contain_group('mock').with({
          :ensure => 'present',
          :name   => 'mock',
          :gid    => '135',
          :before => 'Package[mock]',
        })
      end

      it do
        should contain_package('mock').with({
          :ensure   => 'present',
          :name     => 'mock',
        })
      end

      context 'group_members defined' do
        let(:params) {{ :group_members => ['foo', 'bar'] }}
        it do
          should contain_exec('add-foo-to-group-mock').with({
            :path    => '/usr/bin:/bin:/usr/sbin:/sbin',
            :command => "usermod -a -G mock foo",
            :unless  => "egrep '^mock:' /etc/group | cut -d: -f4 | tr ',' '\\n' | egrep -q '^foo$'",
            :require => 'Group[mock]',
          })
        end
        it do
          should contain_exec('add-bar-to-group-mock').with({
            :path    => '/usr/bin:/bin:/usr/sbin:/sbin',
            :command => "usermod -a -G mock bar",
            :unless  => "egrep '^mock:' /etc/group | cut -d: -f4 | tr ',' '\\n' | egrep -q '^bar$'",
            :require => 'Group[mock]',
          })
        end
      end

      context 'ensure => absent' do
        let(:params) {{ :ensure => 'absent' }}
        it { should contain_group('mock').with_ensure('absent') }
        it { should contain_package('mock').with_ensure('absent') }
      end

      context 'manage_group => false' do
        let(:params) {{ :manage_group => false }}
        it { should_not contain_group('mock') }
      end

      context "group_gid => '1000'" do
        let(:params) {{ :group_gid => 1000 }}
        it { should contain_group('mock').with_gid(1000) }
      end

      context 'group_name => foo' do
        let(:params) {{ :group_name => 'foo' }}
        it { should contain_group('mock').with_name('foo') }
      end

      context 'package_name => foo' do
        let(:params) {{ :package_name => 'foo' }}
        it { should contain_package('mock').with_name('foo') }
      end
    end
  end
end
