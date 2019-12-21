#
# Cookbook:: jupyterhub-chef
# Recipe:: python_python2
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

# python2 install packages(s)
if node['python']['python2'].attribute?('packages')
  package 'python2_install_packages' do
    package_name node['python']['python2']['packages']
  end
end

# python2 install easy_install(s)
if node['python']['python2'].attribute?('easy_installs')
  node['python']['python2']['easy_installs'].each do |easy_install|
    bash "python2_easy_install_#{easy_install}" do
      code "#{node['python']['python2']['easy_install_bin']} #{easy_install}"
    end
  end unless node['python']['python2']['easy_installs'].empty?
end

# python2 upgrade tools
bash 'python2_upgrade_tools' do
  code "#{node['python']['python2']['bin']} -m pip install --upgrade pip setuptools wheel"
end

# python2 create symlink(s)
if node['python']['python2'].attribute?('symlinks')
  node['python']['python2']['symlinks'].each do |target, link|
    link "python2_symlink_#{target}_to_#{link}" do
      target_file target
      to link
    end
  end unless node['python']['python2']['symlinks'].empty?
end

# install pips
if node['python']['python2'].attribute?('pips')
  bash 'pyhton3_install_pips' do
    code "#{node['python']['python2']['bin']} -m pip install #{node['python']['python2']['pips'].join(' ')}"
  end unless node['python']['python2']['pips'].empty?
end
