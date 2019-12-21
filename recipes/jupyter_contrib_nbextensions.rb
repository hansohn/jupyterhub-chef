#
# Cookbook:: jupyterhub-chef
# Recipe:: jupyter_contrib_nbextensions
#
# The MIT License (MIT)
#
# Copyright:: 2019, Ryan Hansohn
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

# enable contrib nbextensions tab in jupyterhub
if node['jupyter']['setup']['enable_contrib_nbextensions']
  bash 'jupyter_enable_contrib_nbextensions' do
    code <<-EOF
      if /bin/grep -qi jupyter-contrib-nbextensions <(python3 -m pip list --format=columns); then
        jupyter contrib nbextension install --system
      fi
      if /bin/grep -qi jupyter-nbextensions-configurator <(python3 -m pip list --format=columns); then
        jupyter nbextensions_configurator enable --system
      fi
    EOF
    environment 'PATH' => "/usr/local/bin:#{ENV['PATH']}"
  end
end
