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

      context 'when fed no parameters' do
        let (:title) { 'my_cmnd'}
        let (:params) {{ 'what' => 'foo bar', 'cmnd' => 'foo_cmnd','ensure' => 'present','comment' => 'blah blah'}}
        it 'should create our sudo::register as expected' do
          should contain_sudo__register("cmnd_my_cmnd").with({
            :ensure  => "present",
            :content => "\n#\n# blah blah\nCmnd_Alias foo_cmnd = foo bar\n",
            :order   => "30"
          })
        end
      end#no params

    end
  end
end
