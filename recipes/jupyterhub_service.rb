#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_service
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

bash 'reload_systemd' do
  code 'systemctl daemon-reload'
  action :nothing
end

template 'install_jupyterhub_service' do
  source 'jupyterhub.service.erb'
  path '/etc/systemd/system/jupyterhub.service'
  owner 'root'
  group 'root'
  mode '644'
  action :create
  notifies :run, 'bash[reload_systemd]', :immediately
end

service 'start_jupyterhub' do
  service_name 'jupyterhub.service'
  action [ :enable, :start ]
end
