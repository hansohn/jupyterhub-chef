
# Cookbook Name:: jupyterhub-chef
# Recipe:: jupyterhub_config
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
package ['openssl']

# create jupyterhub log dir
directory 'create_log_dir' do
  path node['jupyterhub']['config']['log_dir']
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# create jupyterhub runtime dir
directory 'create_runtime_dir' do
  path node['jupyterhub']['config']['runtime_dir']
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# create jupyterhub cookie secret
bash 'inject_cookie_secret' do
  code "openssl rand -hex 32 > #{node['jupyterhub']['config']['runtime_dir']}/jupyterhub_cookie_secret"
  action :nothing
end

file 'create_cookie_secret_file' do
  path "#{node['jupyterhub']['config']['runtime_dir']}/jupyterhub_cookie_secret"
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
  notifies :run, 'bash[inject_cookie_secret]', :immediately
end

# create jupyterhub config file
if node['jupyterhub']['config']['run_as'] != 'root'
  template 'create_jupyterhub_config' do
    path "#{node['jupyterhub']['config']['app_dir']}/current/jupyterhub_config.py"
    source 'jupyterhub_config.erb'
    owner node['jupyterhub']['user']['name']
    group node['jupyterhub']['group']['name']
    mode '0644'
    action :create
  end
else
  template 'create_jupyterhub_config' do
    path "#{node['jupyterhub']['config']['runtime_dir']}/jupyterhub_config.py"
    source 'jupyterhub_config.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end
end

# update /etc/skel with jupyterhub user dir(s)
directory 'jupyterhub_/etc/skel/jupyterhub' do
  path '/etc/skel/jupyterhub'
  action :create
end
