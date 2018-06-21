#
# Cookbook Name:: jupyterhub-chef
# Recipe:: nodejs
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# install node
bash 'install_nodejs' do
  code <<-EOF
    curl --silent --location https://rpm.nodesource.com/setup_#{node['nodejs']['version']} | bash -
    yum install -y nodejs
  EOF
end

# install global npms
node['nodejs']['global_npms'].each do |g_npm|
  bash "install_#{g_npm}" do
    code "npm install -g #{g_npm}"
  end
end unless node['nodejs']['global_npms'].empty?

# install non-global npms
node['nodejs']['npms'].each do |npm|
  bash "install_#{npm}" do
    code "npm install #{npm}"
  end
end unless node['nodejs']['npms'].empty?
