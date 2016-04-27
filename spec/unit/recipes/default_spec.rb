#
# Cookbook Name:: many_resources_same_name
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'many_resources_same_name::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.node.set[:use_case] = [
        {
          "user"=>"jackdaniels",
          "password"=>"the.secret.is.in.the.barrel",
          "tag"=>"administrator",
          "rights"=>[
            {"vhost"=>"/tennessee", "conf"=>".*", "write"=>".*", "read"=>".*"}
          ]
        }
      ]
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a rabbitmq user' do
      expect(chef_run).to add_rabbitmq_user('jackdaniels')
      .with(password: 'the.secret.is.in.the.barrel')
    end

    it 'sets the tag on a rabbitmq user' do
      expect(chef_run).to set_tags_rabbitmq_user('jackdaniels')
      .with(tag: 'administrator')
    end

    it 'sets permissions on a rabbitmq user' do
      expect(chef_run).to set_permissions_rabbitmq_user('jackdaniels')
        .with(vhost: '/tennessee')
        .with(permissions: ".* .* .*")
    end

  end
end
