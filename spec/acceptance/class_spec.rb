require 'spec_helper_acceptance'

describe 'mock class:' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'mock': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe group('mock') do
      it { should exist }
      it { should have_gid 135 }
    end

    describe package('mock') do
      it { should be_installed }
    end
  end

  context 'group_members defined' do
    it 'should add users to mock group' do
      pp =<<-EOS
        class { 'mock':
          group_members => ['daemon','adm']
        }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe user('daemon') do
      it { should belong_to_group 'mock' }
    end

    describe user('adm') do
      it { should belong_to_group 'mock' }
    end
  end

  context 'group_members removed' do
    it 'should remove a user from the mock group' do
      pp =<<-EOS
        class { 'mock':
          group_members => ['daemon']
        }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe user('daemon') do
      it { should belong_to_group 'mock' }
    end

    describe user('adm') do
      it { should_not belong_to_group 'mock' }
    end
  end

  context 'ensure => absent:' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'mock': ensure => absent }
      EOS

      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe group('mock') do
      it { should_not exist }
    end

    describe package('mock') do
      it { should_not be_installed }
    end
  end
end
