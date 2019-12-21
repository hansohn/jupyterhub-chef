#
# Cookbook:: jupyterhub-chef
# Recipe:: jupyterhub_addons
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

# prerequsite packages needed by kernel plugins/libaries
if node['jupyterhub']['addons'].attribute?('packages')
  package 'jupyterhub_addon_packages' do
    package_name node['jupyterhub']['addons']['packages']
  end
end

# install jupyterhub python addons
# these pips often require jupyterhub already installed as a prerequsite and
# therefore can not be installed during the initial python pip run(s).
if node['jupyterhub']['addons'].attribute?('pips')
  bash 'jupyterhub_addon_pips' do
    code <<-EOF
      #{node['python']['python3']['bin']} -m pip install #{node['jupyterhub']['addons']['pips'].join(' ')}
    EOF
    environment 'PATH' => "/usr/local/bin:#{ENV['PATH']}"
  end
end

# install jupyter serverextension
if node['jupyterhub']['addons'].attribute?('serverextensions')
  node['jupyterhub']['addons']['serverextensions'].each do |serverextension|
    bash "jupyterhub_addon_serverextension_#{serverextension}" do
      code <<-EOF
        jupyter serverextension enable #{serverextension} --py --sys-prefix
      EOF
      environment 'PATH' => "/usr/local/bin:#{ENV['PATH']}"
    end
  end unless node['jupyterhub']['addons']['serverextensions'].empty?
end

# install jupyter nbextension
if node['jupyterhub']['addons'].attribute?('nbextensions')
  node['jupyterhub']['addons']['nbextensions'].each do |nbextension|
    bash "jupyterhub_addon_nbextension_#{nbextension}" do
      code <<-EOF
        jupyter nbextension install #{nbextension} --py --sys-prefix
        jupyter nbextension enable #{nbextension} --py --sys-prefix
      EOF
      environment 'PATH' => "/usr/local/bin:#{ENV['PATH']}"
    end
  end unless node['jupyterhub']['addons']['nbextensions'].empty?
end
