#
# Cookbook Name:: jupyterhub-chef
# Recipe:: nodejs
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'build-essential'

bash 'install_nodejs' do
  code <<-EOF
    curl --silent --location https://rpm.nodesource.com/setup_#{node['node']['version']} | bash -
    yum install -y nodejs
    EOF
end

node['node']['global_npms'].each do |g_npm|
  bash "install_#{g_npm}" do
    code <<-EOF
      source "#{node['nvm']['dir']}/nvm.sh"
      npm install -g #{g_npm}
      EOF
  end
end unless node['node']['global_npms'].empty?

node['node']['npms'].each do |npm|
  bash "install_#{npm}" do
    code <<-EOF
      source "#{node['nvm']['dir']}/nvm.sh"
      npm install #{npm}
      EOF
  end
end unless node['node']['npms'].empty?
