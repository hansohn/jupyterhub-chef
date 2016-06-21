#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# include recipe(s)
include_recipe 'build-essential'
include_recipe "#{cookbook_name}::nodejs"

#include package(s)
package [ 'git' ]


group 'create_jupyterhub_group' do
  group_name node['jupyterhub']['group']
  gid node['jupyterhub']['gid']
  action :create
end

user 'create_jupyterhub_user' do
  username node['jupyterhub']['user']
  comment 'Jupyterhub User'
  uid node['jupyterhub']['uid']
  gid node['jupyterhub']['gid']
  home node['jupyterhub']['userhome']
  action :create
end

bash 'install_jupyterhub' do
  cwd '/opt/jupyterhub'
  code <<-EOF
    source "#{node['nvm']['dir']}/nvm.sh"
    pip3 install -r dev-requirements.txt -e .
    npm install
    EOF
  action :nothing
end

git 'download_jupyterhub' do
  repository 'https://github.com/jupyterhub/jupyterhub'
  revision 'master'
  destination '/opt/jupyterhub'
  action :sync
  notifies :run, 'bash[install_jupyterhub]', :immediately
end
