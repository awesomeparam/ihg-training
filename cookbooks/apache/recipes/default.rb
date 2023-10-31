#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
#

chef_gem 'vault' do
  compile_time true
end

require 'vault'

Vault.configure do |config|
  config.address = 'http://54.80.18.64:8200'
  config.token = 'hvs.93nPzyJdGmt5vZalGiJsTLC0'
end

creds = Vault.kv('secret').read('password')

user 'WebAdmin' do
  comment 'Web Admin'
  uid 2000
  home '/home/WebAdmin'
  shell '/bin/bash'
  manage_home true
  password creds.data[:password]
end

package node['apache']['package_name']

#file node['apache']['file_name'] do
  #content '<h1>Welcome Home!</h1>'
#end

apache_vhost 'admins' do
  #site_name 'admins'
  site_port 8080
  #action :create
  notifies :restart, node['apache']['service_resource']
end

apache_vhost node['apache']['site_name'] do
  #site_name node['apache']['site_name']
  action :remove
  notifies :restart, node['apache']['service_resource']
end

apache_vhost 'users' do
  #site_name 'users'
  #site_port 80
  #action :create
  notifies :restart, node['apache']['service_resource']
end

service node['apache']['service_name'] do
  action [:enable, :start]
end
