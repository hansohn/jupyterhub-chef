#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyter
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# include recipe(s)
include_recipe 'build-essential'
include_recipe "#{cookbook_name}::python"


case node['jupyter']['install_method']
when 'python'
  if node['jupyter']['python2']['install']
    # install jupyter and friends
    node['jupyter']['python2']['pips'].each do |pip|
      bash "install_pip2_#{pip}" do
        code "pip2 install -U #{pip}"
      end
    end unless node['jupyter']['python2']['pips'].empty?

    # add ipython module with kernel
    bash "install_python2_ipython_kernel" do
      code "python2 -m IPython kernelspec install-self"
    end
  end

  if node['jupyter']['python3']['install']
    # install jupyter and friends
    node['jupyter']['python3']['pips'].each do |pip|
      bash "install_pip3_#{pip}" do
        code "pip3 install -U #{pip}"
      end
    end unless node['jupyter']['python3']['pips'].empty?

    # add ipython module with kernel
    bash "install_python3_ipython_kernel" do
      code "python3 -m IPython kernelspec install-self"
    end
  end
end
