#!/usr/bin/env rspec
require 'spec_helper'

describe 'sudo::cmnd', :type => :define do
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
        let (:title) { 'my_cmnd'}
        let (:params) {{ 'what' => '/foo/bar', 'cmnd' => 'foo_cmnd'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("cmnd_my_cmnd").with({
            :ensure  => "present",
            :content => "Cmnd_Alias foo_cmnd = /foo/bar\n",
            :order   => "30"
          })
        end
      end#base options

      context 'when called with ensure set to absent' do
        let (:title) { 'my_cmnd'}
        let (:params) {{ 'what' => '/foo/bar', 'cmnd' => 'foo_cmnd', 'ensure' => 'absent'}}
        it 'should not create our sudo::register' do
          should_not contain_sudo__register("cmnd_my_cmnd").with({
            :ensure  => "present",
            :content => "Cmnd_Alias foo_cmnd = /foo/bar\n",
            :order   => "30"
          })
        end
      end#base options

      context 'when called with array of commands' do
        let (:title) { 'my_cmnd'}
        let (:params) {{ 'what' => ['/foo/bar','/bin/baz'], 'cmnd' => 'foo_cmnd'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("cmnd_my_cmnd").with({
            :ensure  => "present",
            :content => "Cmnd_Alias foo_cmnd = /foo/bar, /bin/baz\n",
            :order   => "30"
          })
        end
      end#base options

      context 'when called with comment' do
        let (:title) { 'my_cmnd'}
        let (:params) {{ 'what' => '/foo/bar', 'cmnd' => 'foo_cmnd','comment' => 'blah blah'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("cmnd_my_cmnd").with({
            :ensure  => "present",
            :content => "#\n# blah blah\nCmnd_Alias foo_cmnd = /foo/bar\n",
            :order   => "30"
          })
        end
      end#base options

    end
  end
end
