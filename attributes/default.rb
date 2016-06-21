default['nvm']['version'] = '0.31.0'
default['nvm']['dir'] = '/usr/local/nvm'
default['nvm']['install_list'] = [ '5.2.0' ]
default['nvm']['default_version'] = '5.2.0'

default['node']['version'] = '5.x'
default['node']['npms'] = []
default['node']['global_npms'] = [ 'npm', 'configurable-http-proxy' ]

default['python']['python2']['install'] = true
default['python']['python2']['install_method'] = 'package'
default['python']['python2']['package'] = 'python-devel'
default['python']['python2']['pips'] = []
default['python']['python3']['install'] = true
default['python']['python3']['install_method'] = 'package'
default['python']['python3']['package'] = 'python34-devel'
default['python']['python3']['pips'] = []

default['jupyter']['install_method'] = 'python'
default['jupyter']['python2']['install'] = true
default['jupyter']['python2']['pips'] = [ 'jupyter', 'py4j' ]
default['jupyter']['python3']['install'] = true
default['jupyter']['python3']['pips'] = [ 'jupyter', 'py4j' ]

default['jupyterhub']['user'] = 'jupyterhub'
default['jupyterhub']['uid'] = 9051
default['jupyterhub']['userhome'] = '/var/empty'
default['jupyterhub']['group'] = 'jupyterhub'
default['jupyterhub']['gid'] = 9051
default['jupyterhub']['app_dir'] = '/opt/jupyterhub'
default['jupyterhub']['runtime_dir'] = '/srv/jupyterhub'
default['jupyterhub']['config_dir'] = '/etc/jupyterhub'
default['jupyterhub']['log_dir'] = '/var/log/jupyterhub'
default['jupyterhub']['use_ssl'] = false
default['jupyterhub']['ssl_cert'] = '/etc/ssl/certs/jupyterhub'
default['jupyterhub']['ssl_key'] = '/etc/ssl/private/jupyterhub'
default['jupyterhub']['https_port'] = 8443
default['jupyterhub']['http_port'] = 8000
default['jupyterhub']['users'] = []
default['jupyterhub']['admins'] = []
default['jupyterhub']['create_system_users'] = 'True'

#default['jupyterhub']['pyspark'] = true
#default['juptyerhub']['pyspark']['pip2']['install_list'] = [ 'py4j', 'ipython[notebook]' ]
#default['jupyterhub']['pyspark']['pip3']['install_list'] = []
