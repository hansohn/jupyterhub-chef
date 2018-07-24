#
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_install
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

if node['jupyterhub']['config']['run_as'] != 'root'
  # create jupyterhub group
  group 'create_jupyterhub_group' do
    group_name  node['jupyterhub']['group']['name']
    gid         node['jupyterhub']['group']['gid']
    action :create
  end

  # create jupyterhub user
  user 'create_jupyterhub_user' do
    username    node['jupyterhub']['user']['name']
    uid         node['jupyterhub']['user']['uid']
    home        node['jupyterhub']['user']['home']
    shell       node['jupyterhub']['user']['shell']
    group       node['jupyterhub']['group']['name']
    action      :create
  end

  # create jupyterhub root app_dir
  directory "create_#{node['jupyterhub']['config']['app_dir']}" do
    path node['jupyterhub']['config']['app_dir']
    owner node['jupyterhub']['user']['name']
    group node['jupyterhub']['group']['name']
    mode '0755'
  end
else
  # create jupyterhub root app_dir
  directory "create_#{node['jupyterhub']['config']['app_dir']}" do
    path node['jupyterhub']['config']['app_dir']
    owner 'root'
    group 'root'
    mode '0755'
  end
end

# install jupyterhub
case node['jupyterhub']['install_from']
when 'python'
  # install jupyterhub via python
  bash "install_jupyterhub_#{node['jupyterhub']['install_version']}" do
    code "python3 -m pip install -U jupyterhub==#{node['jupyterhub']['install_version']}"
  end
when 'git'
  # include package(s)
  package ['git']

  # compile jupyterhub
  bash 'install_jupyterhub' do
    code <<-EOF
      npm install
      ./bower-lite
      python3 -m pip install 'jupyter-client>=5.2.0'
      python3 -m pip install -r dev-requirements.txt -e .
    EOF
    cwd "#{node['jupyterhub']['config']['app_dir']}/#{node['jupyterhub']['install_version']}"
    user 'root'
    action :nothing
  end

  # symlink jupyterhub
  link "symlink_#{node['jupyterhub']['config']['app_dir']}/current" do
    target_file "#{node['jupyterhub']['config']['app_dir']}/current"
    to "#{node['jupyterhub']['config']['app_dir']}/#{node['jupyterhub']['install_version']}"
    action :nothing
  end

  # download jupyterhub
  git 'download_jupyterhub' do
    repository node['jupyterhub']['git']['repo']
    revision node['jupyterhub']['install_version']
    destination "#{node['jupyterhub']['config']['app_dir']}/#{node['jupyterhub']['install_version']}"
    action :sync
    notifies :run, 'bash[install_jupyterhub]', :immediately
    notifies :create, "link[symlink_#{node['jupyterhub']['config']['app_dir']}/current]", :immediately
  end
end
