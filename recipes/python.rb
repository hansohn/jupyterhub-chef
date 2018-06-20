#
# Cookbook Name:: jupyterhub-chef
# Recipe:: python
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# include package(s)
package ['curl', 'epel-release']

# python2
if node['python']['python2']['install']
  # install pip2
  bash 'install_pip2' do
    code 'curl https://bootstrap.pypa.io/get-pip.py | python2'
    action :nothing
  end

  # install python2
  package 'install_python2' do
    package_name node['python']['python2']['package']
    notifies :run, 'bash[install_pip2]', :immediately
  end

  # install pips
  node['python']['python2']['pips'].each do |pip|
    bash "install_pip2_#{pip}" do
      code "pip2 install -U #{pip}"
    end
  end unless node['python']['python2']['pips'].empty?
end

# python3
if node['python']['python3']['install']
  # install pip3
  bash 'install_pip3' do
    code 'curl https://bootstrap.pypa.io/get-pip.py | python3'
    action :nothing
  end

  # install python3
  package 'install_python3' do
    package_name node['python']['python3']['package']
    notifies :run, 'bash[install_pip3]', :immediately
  end

  # install pips
  node['python']['python3']['pips'].each do |pip|
    bash "install_pip3_#{pip}" do
      code "pip3 install -U #{pip}"
    end
  end unless node['python']['python3']['pips'].empty?
end
