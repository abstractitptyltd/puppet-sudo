#!/usr/bin/env rspec
require 'spec_helper'

describe 'sudo::runas', :type => :define do
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
          :domain => 'domain.com',
        })
      end

      context 'when called with base options' do
        let (:title) { 'bob'}
        let (:params) {{ 'who' => 'run_user'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("runas_bob").with({
            :ensure  => "present",
            :content => "Runas_Alias BOB = run_user\n",
            :order   => "30"
          })
        end
      end#base options

      context 'when called with ensure set to absent' do
        let (:title) { 'bob'}
        let (:params) {{ 'who' => 'run_user', 'ensure' => 'absent'}}
        it 'should not create our sudo::register' do
          should_not contain_sudo__register("runas_bob").with({
            :ensure  => "present",
            :content => "Runas_Alias BOB = run_user\n",
            :order   => "30"
          })
        end
      end#absent

      context 'when called with an array of who' do
        let (:title) { 'bob'}
        let (:params) {{ 'who' => ['run_user1','run_user2']}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("runas_bob").with({
            :ensure  => "present",
            :content => "Runas_Alias BOB = run_user1, run_user2\n",
            :order   => "30"
          })
        end
      end#array of who

      context 'when called with comment' do
        let (:title) { 'bob'}
        let (:params) {{ 'who' => ['run_user1','run_user2'], 'comment' => 'blah blah'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("runas_bob").with({
            :ensure  => "present",
            :content => "#\n# blah blah\nRunas_Alias BOB = run_user1, run_user2\n",
            :order   => "30"
          })
        end
      end#base options

    end
  end
end
