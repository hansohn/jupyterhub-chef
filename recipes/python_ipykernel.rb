#
# Cookbook Name:: jupyterhub-chef
# Recipe:: python_ipykernel
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

# create python python2 ipykernel kernel
if node['python']['python2']['ipykernel']['install']
  bash 'python_create_python2_ipykernel' do
    code <<-EOF
      virtualenv -p #{node['python']['python2']['ipykernel']['python_version']} #{node['python']['virtualenv']['env_dir']}/#{node['python']['python2']['ipykernel']['kernel_name']}
      source #{node['python']['virtualenv']['env_dir']}/#{node['python']['python2']['ipykernel']['kernel_name']}/bin/activate
      python -m pip install #{node['python']['python2']['ipykernel']['pips'].join(' ')}
      python -m ipykernel install --name "#{node['python']['python2']['ipykernel']['kernel_name']}" --display-name "#{node['python']['python2']['ipykernel']['kernel_displayname']}"
      deactivate
    EOF
  end
end

# create python python3 ipykernel kernel
if node['python']['python3']['ipykernel']['install']
  bash 'python_create_python3_ipykernel' do
    code <<-EOF
      virtualenv -p #{node['python']['python3']['ipykernel']['python_version']} #{node['python']['virtualenv']['env_dir']}/#{node['python']['python3']['ipykernel']['kernel_name']}
      source #{node['python']['virtualenv']['env_dir']}/#{node['python']['python3']['ipykernel']['kernel_name']}/bin/activate
      python -m pip install #{node['python']['python3']['ipykernel']['pips'].join(' ')}
      python -m ipykernel install --name "#{node['python']['python3']['ipykernel']['kernel_name']}" --display-name "#{node['python']['python3']['ipykernel']['kernel_displayname']}"
      deactivate
    EOF
  end
end
