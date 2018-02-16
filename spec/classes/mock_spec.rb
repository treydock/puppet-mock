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
