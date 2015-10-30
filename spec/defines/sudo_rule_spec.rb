#!/usr/bin/env rspec
require 'spec_helper'

describe 'sudo::rule', :type => :define do
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
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user ALL = (root)  ALL\n",
            :order   => "30"
          })
        end
      end#base options

      context 'when called with ensure set to absent' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'ensure' => 'absent'}}
        it 'should not create our sudo::register' do
          should_not contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user ALL = (root)  ALL\n",
            :order   => "30"
          })
        end
      end#base options

      context 'when called with commands' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'commands' => '/bin/foo'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user ALL = (root)  /bin/foo\n",
            :order   => "30"
          })
        end
      end#command

      context 'when called with array of commands' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'commands' => ['/bin/foo','/bin/bar']}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user ALL = (root)  /bin/foo, /bin/bar\n",
            :order   => "30"
          })
        end
      end#array of commands

      context 'when called with server' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'servers' => 'foo'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user foo = (root)  ALL\n",
            :order   => "30"
          })
        end
      end#server

      context 'when called with array of servers' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'servers' => ['foo','bar','baz']}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user foo, bar, baz = (root)  ALL\n",
            :order   => "30"
          })
        end
      end#array of servers

      context 'when called with comment' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'comment' => 'blah blah'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "#\n# blah blah\nmy_user ALL = (root)  ALL\n",
            :order   => "30"
          })
        end
      end#comment

      context 'when called with runas' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'runas' => 'bob'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user ALL = (bob)  ALL\n",
            :order   => "30"
          })
        end
      end#runas

      context 'when called with array of runas' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'runas' => ['bob','bill']}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user ALL = (bob, bill)  ALL\n",
            :order   => "30"
          })
        end
      end#runas

      context 'when called with nopass' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'nopass' => true}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user ALL = (root) NOPASSWD: ALL\n",
            :order   => "30"
          })
        end
      end#nopass

      context 'when called with setenv' do
        let (:title) { 'my_rule'}
        let (:params) {{ 'who' => 'my_user', 'setenv' => true}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("rule_my_rule").with({
            :ensure  => "present",
            :content => "my_user ALL = (root) SETENV: ALL\n",
            :order   => "30"
          })
        end
      end#setenv

    end
  end
end
