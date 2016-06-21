#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_config
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package [ 'openssl' ]

directory 'create_log_dir' do
  path node['jupyterhub']['log_dir']
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

directory 'create_runtime_dir' do
  path node['jupyterhub']['runtime_dir']
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

directory 'create_config_dir' do
  path node['jupyterhub']['config_dir']
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

bash 'inject_cookie_secret' do
  code "openssl rand -base64 2048 > #{node['jupyterhub']['runtime_dir']}/cookie_secret"
  action :nothing
end

file 'create_cookie_secret_file' do
  path "#{node['jupyterhub']['runtime_dir']}/cookie_secret"
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
  notifies :run, 'bash[inject_cookie_secret]', :immediately
end

template 'create_jupyterhub_config' do
  source 'jupyterhub_config.erb'
  path '/opt/jupyterhub/jupyterhub_config.py'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
