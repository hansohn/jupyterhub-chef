#
# Cookbook Name:: jupyterhub-chef
# Recipe:: anaconda_install
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

# create anaconda root app_dir
directory "create_#{node['anaconda']['config']['app_dir']}" do
  path node['anaconda']['config']['app_dir']
end

# create anaconda root app_dir
directory "create_#{node['anaconda']['config']['app_dir']}/downloads" do
  path "#{node['anaconda']['config']['app_dir']}/downloads"
end

# install anaconda
bash 'install_anaconda' do
  code "bash #{node['anaconda']['config']['app_dir']}/downloads/#{node['anaconda']['version']}-Linux-x86_64.sh -b -p #{node['anaconda']['config']['app_dir']}/#{node['anaconda']['version']}"
  only_if { File.exist?("#{node['anaconda']['config']['app_dir']}/downloads/#{node['anaconda']['version']}-Linux-x86_64.sh") }
  action :nothing
end

# symlink anaconda
link "symlink_#{node['anaconda']['config']['app_dir']}/current" do
  target_file "#{node['anaconda']['config']['app_dir']}/current"
  to "#{node['anaconda']['config']['app_dir']}/#{node['anaconda']['version']}"
  action :nothing
end

# set anaconda envs
link 'set_anaconda_envs' do
  target_file '/etc/profile.d/conda.sh'
  to "#{node['anaconda']['config']['app_dir']}/current/etc/profile.d/conda.sh"
  action :nothing
end

anaconda_source = -> { node['anaconda']['source'][node['anaconda']['version']]['url'] }
anaconda_checksum = -> { node['anaconda']['source'][node['anaconda']['version']]['checksum'] }

# download anaconda
remote_file 'download_anaconda' do
  path "#{node['anaconda']['config']['app_dir']}/downloads/#{node['anaconda']['version']}-Linux-x86_64.sh"
  source anaconda_source.call
  checksum anaconda_checksum.call
  mode '0755'
  action :create_if_missing
  notifies :run, 'bash[install_anaconda]', :immediately
  notifies :create, "link[symlink_#{node['anaconda']['config']['app_dir']}/current]", :immediately
  notifies :create, 'link[set_anaconda_envs]', :immediately
end
