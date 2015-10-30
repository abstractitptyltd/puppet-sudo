#!/usr/bin/env rspec
require 'spec_helper'

describe 'sudo::host', :type => :define do
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
        let (:title) { 'my_host'}
        let (:params) {{ 'where' => 'host1'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("host_my_host").with({
            :ensure  => "present",
            :content => "Host_Alias MY_HOST = host1\n",
            :order   => "30"
          })
        end
      end#no params

      context 'when called with ensure set to absent' do
        let (:title) { 'my_host'}
        let (:params) {{ 'where' => 'host1', 'ensure' => 'absent'}}
        it 'should not create our sudo::register' do
          should_not contain_sudo__register("host_my_host").with({
            :ensure  => "present",
            :content => "Host_Alias MY_HOST = host1\n",
            :order   => "30"
          })
        end
      end#no params

      context 'when called with an array of where' do
        let (:title) { 'my_host'}
        let (:params) {{ 'where' => ['host1','host2']}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("host_my_host").with({
            :ensure  => "present",
            :content => "Host_Alias MY_HOST = host1, host2\n",
            :order   => "30"
          })
        end
      end#no params

      context 'when called with a comment' do
        let (:title) { 'my_host'}
        let (:params) {{ 'where' => ['host1','host2'], 'comment' => 'blah blah'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("host_my_host").with({
            :ensure  => "present",
            :content => "#\n# blah blah\nHost_Alias MY_HOST = host1, host2\n",
            :order   => "30"
          })
        end
      end#comment

    end
  end
end
