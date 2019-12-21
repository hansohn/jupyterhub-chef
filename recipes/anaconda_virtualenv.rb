#
# Cookbook:: jupyterhub-chef
# Recipe:: anaconda_virtualenv
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

# anaconda create virtualenv(s)
if node['anaconda'].attribute?('virtualenvs')
  node['anaconda']['virtualenvs'].each do |name, params|
    bash "anaconda_create_virtualenv_#{name}" do
      code <<-EOF
        source /etc/profile.d/anaconda.sh
        if [ ! -d #{node['anaconda']['config']['app_dir']}/current/envs/#{name} ]; then
          conda create -n #{name} python=#{params['python']} -y
        fi
        source activate #{name}
        conda install --name #{name} #{params['condas'].join(' ')} -y
        python -m pip install #{params['pips'].join(' ')} -y
        conda deactivate
      EOF
    end
  end unless node['anaconda']['virtualenvs'].empty?
end
