#
# Cookbook:: jupyterhub-chef
# Recipe:: anaconda
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# install anaconda
include_recipe "#{cookbook_name}::anaconda_install"
include_recipe "#{cookbook_name}::anaconda_config"
