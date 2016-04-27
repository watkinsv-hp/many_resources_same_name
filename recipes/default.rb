#
# Cookbook Name:: many_resources_same_name
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


# pretend this is coming from somewhere more useful such as an
# encrypted data bag item or some authenticated data store being
# accessed by a helper or vault or something...
node['use_case'].each do |rmq_user|
  rabbitmq_user rmq_user['user'] do
    password rmq_user['password']
    action :add
  end

  rabbitmq_user rmq_user['user'] do
    tag rmq_user['tag']
    action :set_tags
  end

  rmq_user['rights'].each do |right|
    rabbitmq_user rmq_user['user'] do
      vhost right['vhost']
      permissions "#{right['conf']} #{right['write']} #{right['read']}"
      action :set_permissions
    end
  end
end
