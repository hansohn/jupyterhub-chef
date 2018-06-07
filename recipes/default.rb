#
# Cookbook Name:: jupyterhub-chef
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# install jupyterhub prerequsites
include_recipe "#{cookbook_name}::python"
include_recipe "#{cookbook_name}::nodejs"
include_recipe "#{cookbook_name}::anaconda_install"
include_recipe "#{cookbook_name}::anaconda_config"

# install jupyterhub
include_recipe "#{cookbook_name}::jupyterhub_install"
include_recipe "#{cookbook_name}::jupyterhub_config"
include_recipe "#{cookbook_name}::jupyterhub_parallel"
include_recipe "#{cookbook_name}::jupyterhub_service"
include_recipe "#{cookbook_name}::jupyterhub_ipykernel"
