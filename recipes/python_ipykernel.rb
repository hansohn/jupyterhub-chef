#
# Cookbook Name:: jupyterhub-chef
# Recipe:: python_ipykernel
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
