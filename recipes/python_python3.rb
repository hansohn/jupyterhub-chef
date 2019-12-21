#
# Cookbook:: jupyterhub-chef
# Recipe:: python_python3
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

# python3 install packages(s)
if node['python']['python3'].attribute?('packages')
  package 'python3_install_packages' do
    package_name node['python']['python3']['packages']
  end
end

# python3 install easy_install(s)
if node['python']['python3'].attribute?('easy_installs')
  node['python']['python3']['easy_installs'].each do |easy_install|
    bash "python3_easy_install_#{easy_install}" do
      code "#{node['python']['python3']['easy_install_bin']} #{easy_install}"
    end
  end unless node['python']['python3']['easy_installs'].empty?
end

# python3 upgrade tools
bash 'python3_upgrade_tools' do
  code "#{node['python']['python3']['bin']} -m pip install --upgrade pip setuptools wheel"
end

# python3 create symlink(s)
if node['python']['python3'].attribute?('symlinks')
  node['python']['python3']['symlinks'].each do |target, link|
    link "python3_symlink_#{target}_to_#{link}" do
      target_file target
      to link
    end
  end unless node['python']['python3']['symlinks'].empty?
end

# install pips
if node['python']['python3'].attribute?('pips')
  bash 'pyhton3_install_pips' do
    code "#{node['python']['python3']['bin']} -m pip install #{node['python']['python3']['pips'].join(' ')}"
  end unless node['python']['python3']['pips'].empty?
end
