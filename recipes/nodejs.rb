#
# Cookbook Name:: jupyterhub-chef
# Recipe:: nodejs
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

# install node
bash 'install_nodejs' do
  code <<-EOF
    curl --silent --location https://rpm.nodesource.com/setup_#{node['nodejs']['version']} | bash -
    yum install -y nodejs
  EOF
end

# install global npms
node['nodejs']['global_npms'].each do |g_npm|
  bash "install_#{g_npm}" do
    code "npm install -g #{g_npm}"
  end
end unless node['nodejs']['global_npms'].empty?

# install non-global npms
node['nodejs']['npms'].each do |npm|
  bash "install_#{npm}" do
    code "npm install #{npm}"
  end
end unless node['nodejs']['npms'].empty?
