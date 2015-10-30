#!/usr/bin/env rspec
require 'spec_helper'
require 'pry'

describe 'sudo::config' do
  let(:pre_condition){ 'class{"sudo":}'}
  on_supported_os({
      :hardwaremodels => ['x86_64'],
      :supported_os   => [
        {
          "operatingsystem" => "Ubuntu",
          "operatingsystemrelease" => [
            "14.04"
          ]
        },
        {
          "operatingsystem" => "CentOS",
          "operatingsystemrelease" => [
            "7"
          ]
        }
      ],
    }).each do |os, facts|
    context "When on an #{os} system" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/tmp',
        })
      end
      it { is_expected.to compile.with_all_deps }
      context 'when fed no parameters' do
        it { should create_class('sudo::config') }

        it 'should create the rules file concat' do
          should contain_concat('/etc/sudoers').with({
            :owner => 'root',
            :group => 'root',
            :mode  => '0440'
          })
        end

        it 'should create the header with sudo::register' do
          should contain_sudo__register('sudo_header').with({
            :ensure => 'present',
            :order  => '10'
          })
        end
      end#no params

      context 'when sudoers_dot_d is true' do
      end

      context 'when extra_path is set' do
      end

      context 'when extra_shells is set' do
      end

      context 'when extra_shells is set' do
      end

    end
  end
end
