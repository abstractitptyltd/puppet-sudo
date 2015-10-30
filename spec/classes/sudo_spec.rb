#!/usr/bin/env rspec
require 'spec_helper'
require 'pry'

describe 'sudo' do
  let(:pre_condition){ 'class{"sudo::params":}'}
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
        it { should create_class('sudo') }

        it 'should contain the sudo::install class' do
          should contain_class('sudo::install')
        end

        it 'should contain the sudo::config class' do
          should contain_class('sudo::config')
        end
      end#no params
    end
  end
end
