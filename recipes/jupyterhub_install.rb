#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


#include package(s)
package [ 'git' ]

# create jupyterhub user/group
if node['jupyterhub']['config']['run_as'] != 'root'
  # create jupyterhub group
  group 'create_jupyterhub_group' do
    group_name  node['jupyterhub']['group']['name']
    gid         node['jupyterhub']['group']['gid']
    action :create
  end

  # create jupyterhub user
  user 'create_jupyterhub_user' do
    username    node['jupyterhub']['user']['name']
    uid         node['jupyterhub']['user']['uid']
    home        node['jupyterhub']['user']['home']
    shell       node['jupyterhub']['user']['shell']
    group       node['jupyterhub']['group']['name']
    action      :create
  end
end

# install jupyterhub
bash 'install_jupyterhub' do
  code <<-EOF
    pip3 install -r dev-requirements.txt -e .
    npm install
  EOF
  cwd node['jupyterhub']['config']['app_dir']
  action :nothing
end

# install sudospawner
bash 'install_sudospawner' do
  code 'sudo pip install git+https://github.com/jupyter/sudospawner'
  cwd node['jupyterhub']['config']['app_dir']
  action :nothing
end

# download jupyterhub
git 'download_jupyterhub' do
  repository node['jupyterhub']['git']['repo']
  revision node['jupyterhub']['git']['revision']
  destination node['jupyterhub']['config']['app_dir']
  action :sync
  notifies :run, 'bash[install_jupyterhub]', :immediately
end
