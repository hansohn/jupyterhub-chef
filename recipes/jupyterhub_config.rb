#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_config
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


# include package(s)
package [ 'openssl' ]

# create jupyterhub log dir
directory 'create_log_dir' do
  path node['jupyterhub']['config']['log_dir']
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# create jupyterhub runtime dir
directory 'create_runtime_dir' do
  path node['jupyterhub']['config']['runtime_dir']
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# create jupyterhub cookie secret
bash 'inject_cookie_secret' do
  code "openssl rand -hex 32 > #{node['jupyterhub']['config']['runtime_dir']}/jupyterhub_cookie_secret"
  action :nothing
end

file 'create_cookie_secret_file' do
  path "#{node['jupyterhub']['config']['runtime_dir']}/jupyterhub_cookie_secret"
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
  notifies :run, 'bash[inject_cookie_secret]', :immediately
end

# create jupyterhub config file
if node['jupyterhub']['config']['run_as'] != 'root'
  template 'create_jupyterhub_config' do
    path "#{node['jupyterhub']['config']['app_dir']}/current/jupyterhub_config.py"
    source 'jupyterhub_config.erb'
    owner node['jupyterhub']['user']['name']
    group node['jupyterhub']['group']['name']
    mode '0644'
    action :create
  end
else
  template 'create_jupyterhub_config' do
    path "#{node['jupyterhub']['config']['runtime_dir']}/jupyterhub_config.py"
    source 'jupyterhub_config.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end
end

# update /etc/skel with jupyterhub user dir(s)
directory 'jupyterhub_/etc/skel/jupyterhub' do
  path '/etc/skel/jupyterhub'
  action :create
end

