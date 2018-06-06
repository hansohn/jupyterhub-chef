#
# Cookbook Name:: jupyterhub-chef
# Recipe:: anaconda_ipykernel
#
# Copyright (c) 2017 The Authors, All Rights Reserved.


# create anaconda python2 ipykernel kernel
if node['anaconda']['python2']['ipykernel']['install']
  bash "anaconda_create_#{node['anaconda']['python2']['ipykernel']['kernel_name']}_ipykernel" do
    code <<-EOF
      source /etc/profile.d/conda.sh
      conda create -n #{node['anaconda']['python2']['ipykernel']['kernel_name']} python=#{node['anaconda']['python2']['ipykernel']['python_version']} anaconda -y
      conda activate #{node['anaconda']['python2']['ipykernel']['kernel_name']}
      conda install --name #{node['anaconda']['python2']['ipykernel']['kernel_name']} #{node['anaconda']['python2']['ipykernel']['condas'].join(' ')} -y
      python -m pip install #{node['anaconda']['python2']['ipykernel']['pips'].join(' ')}
      python -m ipykernel install --name "#{node['anaconda']['python2']['ipykernel']['kernel_name']}" --display-name "#{node['anaconda']['python2']['ipykernel']['kernel_displayname']}"
      conda deactivate
    EOF
  end
end

# create anaconda python3 ipykernel kernel
if node['anaconda']['python3']['ipykernel']['install']
  bash "anaconda_create_#{node['anaconda']['python3']['ipykernel']['kernel_name']}_ipykernel" do
    code <<-EOF
      source /etc/profile.d/conda.sh
      conda create -n #{node['anaconda']['python3']['ipykernel']['kernel_name']} python=#{node['anaconda']['python3']['ipykernel']['python_version']} anaconda -y
      conda activate #{node['anaconda']['python3']['ipykernel']['kernel_name']}
      conda install --name #{node['anaconda']['python3']['ipykernel']['kernel_name']} #{node['anaconda']['python3']['ipykernel']['condas'].join(' ')} -y
      python -m pip install #{node['anaconda']['python3']['ipykernel']['pips'].join(' ')}
      python -m ipykernel install --name "#{node['anaconda']['python3']['ipykernel']['kernel_name']}" --display-name "#{node['anaconda']['python3']['ipykernel']['kernel_displayname']}"
      conda deactivate
    EOF
  end
end
