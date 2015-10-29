#!/usr/bin/env rspec
require 'spec_helper'

describe 'sudo::register', :type => :define do
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
          :domain => 'domain.com',
        })
      end

      context 'when fed no parameters' do
        let (:title) { 'my_register'}
        let (:params) {{ 'ensure' => 'present','content' => 'my_content', 'order' => '20'}}
        it 'should create our concat::fragment as expected' do
          should contain_concat__fragment("sudo_fragment_my_register").with({
            :ensure  =>"present",
            :target  =>"/etc/sudoers",
            :content =>"my_content",
            :order   =>"20"
          })
        end
      end#no params

    end
  end
end
