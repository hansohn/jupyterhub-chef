#
# Cookbook Name:: jupyterhub-chef
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# install prerequsites
include_recipe "#{cookbook_name}::python"
include_recipe "#{cookbook_name}::nodejs"
include_recipe "#{cookbook_name}::jupyter"

# install jupyterhub
include_recipe "#{cookbook_name}::jupyterhub_install"
include_recipe "#{cookbook_name}::jupyterhub_config"
include_recipe "#{cookbook_name}::jupyterhub_service"
