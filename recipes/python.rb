#
# Cookbook Name:: jupyterhub-chef
# Recipe:: python
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

# include package(s)
package ['curl']

# include build essentials
build_essential 'install_build_essential' do
  action :install
end

# python2
if node['python']['python2']['install']
  # install pip2
  bash 'install_pip2' do
    code "curl https://bootstrap.pypa.io/get-pip.py | #{node['python']['python2']['bin']}"
    action :nothing
  end

  # install python2 prerequisites
  if node['python']['python2']['prerequisites'].any?
    bash 'install_python2_prerequisites' do
      code "yum install -y #{node['python']['python2']['prerequisites'].join(' ')}"
    end
  end

  # install python2
  package 'install_python2' do
    package_name node['python']['python2']['package']
    notifies :run, 'bash[install_pip2]', :immediately
  end

  # set alternatives
  node['python']['python2']['alternatives'].each do |link, args|
    alternatives "python2_alternative_#{link}" do
      link_name link
      path args['path']
      priority args['priority']
      action :install
    end
  end unless node['python']['python2']['alternatives'].empty?

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
    code "curl https://bootstrap.pypa.io/get-pip.py | #{node['python']['python3']['bin']}"
    action :nothing
  end

  # install python3 prerequisites
  if node['python']['python3']['prerequisites'].any?
    bash 'install_python3_prerequisites' do
      code "yum install -y #{node['python']['python3']['prerequisites'].join(' ')}"
    end
  end

  # install python3
  package 'install_python3' do
    package_name node['python']['python3']['package']
    notifies :run, 'bash[install_pip3]', :immediately
  end

  # set alternatives
  node['python']['python3']['alternatives'].each do |link, args|
    alternatives "python3_alternative_#{link}" do
      link_name link
      path args['path']
      priority args['priority']
      action :install
    end
  end unless node['python']['python3']['alternatives'].empty?

  # install pips
  node['python']['python3']['pips'].each do |pip|
    bash "install_pip3_#{pip}" do
      code "pip3 install -U #{pip}"
    end
  end unless node['python']['python3']['pips'].empty?
end
