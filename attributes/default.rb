# node attributes
default['node']['version'] = '6.x'
default['node']['npms'] = []
default['node']['global_npms'] = [ 'npm', 'configurable-http-proxy' ]

# python attributes
default['python']['python2']['install'] = true
default['python']['python2']['install_method'] = 'package'
default['python']['python2']['package'] = 'python-devel'
default['python']['python2']['pips'] = []
default['python']['python3']['install'] = true
default['python']['python3']['install_method'] = 'package'
default['python']['python3']['package'] = 'python34-devel'
default['python']['python3']['pips'] = []

# jupyter attributes
default['jupyter']['install_method'] = 'python'
default['jupyter']['python2']['install'] = true
default['jupyter']['python2']['pips'] = [ 'jupyter', 'py4j' ]
default['jupyter']['python3']['install'] = true
default['jupyter']['python3']['pips'] = [ 'jupyter', 'py4j' ]

# jupyterhub attributes
default['jupyterhub']['git']['repo'] = 'https://github.com/jupyterhub/jupyterhub'
default['jupyterhub']['git']['revision'] = 'master'
default['jupyterhub']['group']['name'] = 'jupyterhub'
default['jupyterhub']['group']['gid'] = 10000
default['jupyterhub']['user']['name'] = 'jupyterhub'
default['jupyterhub']['user']['uid'] = 15000
default['jupyterhub']['user']['home'] = '/home/jupyterhub'
default['jupyterhub']['user']['shell'] = '/bin/bash'
default['jupyterhub']['config']['run_as'] = 'root'
default['jupyterhub']['config']['pid_file'] = '/var/run/jupyter.pid'
default['jupyterhub']['config']['app_dir'] = '/opt/jupyterhub'
default['jupyterhub']['config']['runtime_dir'] = '/srv/jupyterhub'
default['jupyterhub']['config']['log_dir'] = '/var/log/jupyterhub'
default['jupyterhub']['config']['enable_ssl'] = false
default['jupyterhub']['config']['http_port'] = 8000
default['jupyterhub']['config']['https_port'] = 8443
default['jupyterhub']['config']['jupyterhub_config']['ssl_cert'] = '/etc/ssl/certs/jupyterhub.crt'
default['jupyterhub']['config']['jupyterhub_config']['ssl_key'] = '/etc/ssl/private/jupyterhub.key'
default['jupyterhub']['config']['jupyterhub_config']['users'] = []
default['jupyterhub']['config']['jupyterhub_config']['admins'] = []
default['jupyterhub']['config']['jupyterhub_config']['create_system_users'] = 'True'

# pyspark kernal - still in development -
#default['jupyterhub']['pyspark'] = true
#default['juptyerhub']['pyspark']['pip2']['install_list'] = [ 'py4j', 'ipython[notebook]' ]
#default['jupyterhub']['pyspark']['pip3']['install_list'] = []
