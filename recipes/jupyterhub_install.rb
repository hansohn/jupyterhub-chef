#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.


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

  # create jupyterhub root app_dir
  directory "create_#{node['jupyterhub']['config']['app_dir']}" do
    path node['jupyterhub']['config']['app_dir']
    owner node['jupyterhub']['user']['name']
    group node['jupyterhub']['group']['name']
    mode '0755'
  end
else
  # create jupyterhub root app_dir
  directory "create_#{node['jupyterhub']['config']['app_dir']}" do
    path node['jupyterhub']['config']['app_dir']
    owner 'root'
    group 'root'
    mode '0755'
  end
end

# install jupyterhub
case node['jupyterhub']['install_from']
when 'python'
  # install jupyterhub via python
  node['jupyterhub']['python3']['pips'].each do |pip|
    bash "install_pip3_#{pip}" do
      code "python3 -m pip install -U #{pip}"
    end
  end unless node['jupyterhub']['python3']['pips'].empty?
when 'git'
  # include package(s)
  package [ 'git' ]

  # compile jupyterhub
  bash 'install_jupyterhub' do
    code <<-EOF
      npm install
      ./bower-lite
      python3 -m pip install 'jupyter-client>=5.2.0'
      python3 -m pip install -r dev-requirements.txt -e .
    EOF
    cwd "#{node['jupyterhub']['config']['app_dir']}/#{node['jupyterhub']['install_version']}"
    user 'root'
    action :nothing
  end

  # symlink jupyterhub
  link "symlink_#{node['jupyterhub']['config']['app_dir']}/current" do
    target_file "#{node['jupyterhub']['config']['app_dir']}/current"
    to "#{node['jupyterhub']['config']['app_dir']}/#{node['jupyterhub']['install_version']}"
    action :nothing
  end

  # download jupyterhub
  git 'download_jupyterhub' do
    repository node['jupyterhub']['git']['repo']
    revision node['jupyterhub']['install_version']
    destination "#{node['jupyterhub']['config']['app_dir']}/#{node['jupyterhub']['install_version']}"
    action :sync
    notifies :run, 'bash[install_jupyterhub]', :immediately
    notifies :create, "link[symlink_#{node['jupyterhub']['config']['app_dir']}/current]", :immediately
  end
end
