#
# Cookbook Name:: jupyterhub-chef
# Recipe:: nvm
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# source nvm for all users
file 'nvm_profile' do
  path '/etc/profile.d/nvm.sh'
  content <<-EOF
    export NVM_DIR="#{node['nvm']['dir']}"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    EOF
  owner 'root'
  group 'root'
  mode '644'
  action :nothing
end

bash 'install_nvm' do
  code "curl -o- https://raw.githubusercontent.com/creationix/nvm/v#{node['nvm']['version']}/install.sh | NVM_DIR=#{node['nvm']['dir']} bash"
  not_if "grep #{node['nvm']['version']} <<< $(nvm --version)"
  notifies :create, 'file[nvm_profile]', :immediately
end

node['nvm']['install_list'].each do |node_ver|
  bash "install_node_#{node_ver}" do
    code <<-EOF
      source "#{node['nvm']['dir']}/nvm.sh"
      nvm install #{node_ver}
      EOF
  end
end

bash 'set_node_default' do
  code <<-EOF
    source "#{node['nvm']['dir']}/nvm.sh"
    nvm alias default #{node['nvm']['default_version']}
    nvm use default
    EOF
end unless node['nvm']['default_version'].nil?
