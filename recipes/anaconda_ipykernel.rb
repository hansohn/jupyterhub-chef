#
# Cookbook Name:: jupyterhub-chef
# Recipe:: anaconda_ipykernel
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
