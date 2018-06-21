#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_ipykernel
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

# create jupyterhub ipykernel kernels
node['jupyterhub']['kernels'].each do |kernel, config|
  if config['install']
    if config['type'] == 'python'
      # create python ipykernel kernel
      bash "create_python_#{kernel}_kernel" do
        code <<-EOF
          /usr/bin/virtualenv -p #{config['python_version']} #{node['python']['virtualenv']['shared_home']}/#{kernel}
          source #{node['python']['virtualenv']['shared_home']}/#{kernel}/bin/activate
          python -m pip install -U #{config['pips'].join(' ')}
          python -m ipykernel install --name "#{config['kernel_name']}" --display-name "#{config['kernel_displayname']}"
          deactivate
        EOF
      end
    elsif config['type'] == 'anaconda'
      # create anaconda ipykernel kernel
      bash "create_anaconda_#{kernel}_kernel" do
        code <<-EOF
          source /etc/profile.d/conda.sh
          conda create -n #{kernel} python=#{config['python_version']} anaconda -y
          conda activate #{kernel}
          conda install --name #{kernel} #{config['condas'].join(' ')} -y
          python -m pip install -U #{config['pips'].join(' ')}
          python -m ipykernel install --name "#{config['kernel_name']}" --display-name "#{config['kernel_displayname']}"
          conda deactivate
        EOF
      end
    end
  end
end
