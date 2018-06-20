#
# Cookbook:: jupyterhub-chef
# Recipe:: jupyterhub
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# install jupyterhub
include_recipe "#{cookbook_name}::jupyterhub_install"
include_recipe "#{cookbook_name}::jupyterhub_config"
include_recipe "#{cookbook_name}::jupyterhub_parallel"
include_recipe "#{cookbook_name}::jupyterhub_service"
include_recipe "#{cookbook_name}::jupyterhub_ipykernel"
