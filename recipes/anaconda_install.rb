#
# Cookbook Name:: jupyterhub-chef
# Recipe:: anaconda_install
#
# Copyright (c) 2017 The Authors, All Rights Reserved.


# create anaconda root app_dir
directory "create_#{node['anaconda']['config']['app_dir']}" do
  path node['anaconda']['config']['app_dir']
end

# create anaconda root app_dir
directory "create_#{node['anaconda']['config']['app_dir']}/downloads" do
  path "#{node['anaconda']['config']['app_dir']}/downloads"
end

# install anaconda
bash 'install_anaconda' do
  code "bash #{node['anaconda']['config']['app_dir']}/downloads/#{node['anaconda']['version']}-Linux-x86_64.sh -b -p #{node['anaconda']['config']['app_dir']}/#{node['anaconda']['version']}"
  only_if { File.exist?("#{node['anaconda']['config']['app_dir']}/downloads/#{node['anaconda']['version']}-Linux-x86_64.sh")}
  action :nothing
end

# symlink anaconda
link "symlink_#{node['anaconda']['config']['app_dir']}/current" do
  target_file "#{node['anaconda']['config']['app_dir']}/current"
  to "#{node['anaconda']['config']['app_dir']}/#{node['anaconda']['version']}"
  action :nothing
end

# set anaconda envs
link "set_anaconda_envs" do
  target_file "/etc/profile.d/conda.sh"
  to "#{node['anaconda']['config']['app_dir']}/current/etc/profile.d/conda.sh"
  action :nothing
end

# download anaconda
remote_file 'download_anaconda' do
  path "#{node['anaconda']['config']['app_dir']}/downloads/#{node['anaconda']['version']}-Linux-x86_64.sh"
  source node['anaconda']['source']['url']
  checksum node['anaconda']['source']['checksum']
  mode '0755'
  action :create_if_missing
  notifies :run, "bash[install_anaconda]", :immediately
  notifies :create, "link[symlink_#{node['anaconda']['config']['app_dir']}/current]", :immediately
  notifies :create, "link[set_anaconda_envs]", :immediately
end
