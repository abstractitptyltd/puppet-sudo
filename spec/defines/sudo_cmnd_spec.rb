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
        # let (:title) { 'my_cmnd'}
        # let (:params) {{ 'what' => 'my_val','cmnd' => 'my_command', 'ensure' => 'present', 'comment' => 'blah blah'}}
        # it 'should lay down our fact file as expected' do
        #   should contain_file("#{facterbasepath}/facts.d/my_fact.yaml").with({
        #     :path=>"#{facterbasepath}/facts.d/my_fact.yaml",
        #     :ensure=>"present",
        #     :owner=>"root",
        #     :group=>"puppet",
        #     :mode=>"0640"
        #   }).with_content("# custom fact my_fact\n---\nmy_fact: \"my_val\"\n")
        # end
      end#no params

    end
  end
end
