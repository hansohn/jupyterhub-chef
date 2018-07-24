#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_ipykernel
#
# The MIT License (MIT)
#
# Copyright:: 2018, Ryan Hansohn
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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
