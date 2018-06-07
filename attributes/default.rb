# node attributes
default['node']['version'] = '6.x'
default['node']['npms'] = []
default['node']['global_npms'] = [ 'npm', 'configurable-http-proxy' ]

# python attributes
default['python']['python2']['install'] = true
default['python']['python2']['package'] = 'python-devel'
default['python']['python2']['pips'] = [ 'pip', 'setuptools', 'wheel', 'virtualenv', 'jupyter', 'py4j', 'ipyparallel' ]
default['python']['python2']['ipykernel']['install'] = false
default['python']['python2']['ipykernel']['python_version'] = 'python2'
default['python']['python2']['ipykernel']['kernel_name'] = 'python2'
default['python']['python2']['ipykernel']['kernel_displayname'] = 'Python 2'
default['python']['python2']['ipykernel']['pips'] = ['ipykernel']
default['python']['python3']['install'] = true
default['python']['python3']['package'] = 'python34-devel'
default['python']['python3']['pips'] = [ 'pip', 'setuptools', 'wheel', 'virtualenv', 'jupyter', 'py4j', 'ipyparallel' ]
default['python']['python3']['ipykernel']['install'] = false
default['python']['python3']['ipykernel']['python_version'] = 'python3'
default['python']['python3']['ipykernel']['kernel_name'] = 'python3'
default['python']['python3']['ipykernel']['kernel_displayname'] = 'Python 3'
default['python']['python3']['ipykernel']['pips'] = ['ipykernel']
default['python']['virtualenv']['env_dir'] = '/opt/virtualenv'

# jupyterhub attributes
default['jupyterhub']['install_from'] = 'python'
default['jupyterhub']['install_version'] = '0.8.1'
case node['jupyterhub']['install_from']
when 'git'
  default['jupyterhub']['git']['repo'] = 'https://github.com/jupyterhub/jupyterhub'
when 'python'
  case node['jupyterhub']['install_version']
  when '0.8.1'
    default['jupyterhub']['python3']['pips'] = [ 'jupyterhub==0.8.1' ]
  end
end
default['jupyterhub']['addons']['pips'] = ['jupyterhub-ldap-authenticator']
default['jupyterhub']['addons']['condas'] = ['']
default['jupyterhub']['addons']['nbextensions'] = ['']
default['jupyterhub']['group']['name'] = 'jupyterhub'
default['jupyterhub']['group']['gid'] = 10000
default['jupyterhub']['user']['name'] = 'jupyterhub'
default['jupyterhub']['user']['uid'] = 15000
default['jupyterhub']['user']['home'] = '/home/jupyterhub'
default['jupyterhub']['user']['shell'] = '/bin/bash'
default['jupyterhub']['db']['type'] = 'sqlite'
default['jupyterhub']['db']['user'] = 'jupyterhub_db_user'
default['jupyterhub']['db']['pass'] = 'jupyterhub_db_pass'
default['jupyterhub']['db']['host'] = 'jupyterhub_db_server'
default['jupyterhub']['db']['port'] = '5432'
default['jupyterhub']['db']['name'] = 'jupyterhub_db_name'
default['jupyterhub']['config']['run_as'] = 'root'
default['jupyterhub']['config']['pid_file'] = '/var/run/jupyter.pid'
default['jupyterhub']['config']['app_dir'] = '/opt/jupyterhub'
default['jupyterhub']['config']['runtime_dir'] = '/srv/jupyterhub'
default['jupyterhub']['config']['log_dir'] = '/var/log/jupyterhub'
default['jupyterhub']['config']['allow_parallel_computing'] = true
default['jupyterhub']['config']['enable_ssl'] = false
default['jupyterhub']['config']['enable_ldap'] = false
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ip'] = ''
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.port'] = '8000'
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ssl_port'] = '8443'
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.hub_ip'] = '127.0.0.1'
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.hub_port'] = '8081'
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.proxy_api_ip'] = '127.0.0.1'
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.proxy_api_port'] = '8001' 
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ssl_cert'] = '/etc/ssl/certs/jupyterhub.crt'
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ssl_key'] = '/etc/ssl/private/jupyterhub.key'
default['jupyterhub']['config']['jupyterhub_config']['Authenticator.whitelist'] = []
default['jupyterhub']['config']['jupyterhub_config']['Authenticator.admin_users'] = []
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.authenticator_class'] = 'jupyterhub.auth.PAMAuthenticator'
default['jupyterhub']['config']['jupyterhub_config']['JupyterHub.authenticator_ldap_class'] = 'ldapauthenticator.LDAPAuthenticator'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.server_hosts'] = ['ldap://ldapserver-1.example.com:389', 'ldap://ldapserver-2.example.com:389']
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.bind_user_dn'] = 'uid=ldapquery,cn=users,cn=accounts,dc=example,dc=com'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.bind_user_password'] = 'password'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.user_search_base'] = 'cn=users,cn=accounts,dc=example,dc=com'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.user_search_filter'] = '(&(objectClass=person)(uid={username}))'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.user_membership_attribute'] = 'memberOf'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.group_search_base'] = 'cn=groups,cn=accounts,dc=example,dc=com'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.group_search_filter'] = '(&(objectClass=ipausergroup)(memberOf={group}))'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.allowed_groups'] = ['cn=jupyterhub-users,cn=groups,cn=accounts,dc=example,dc=com']
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.allow_nested_groups'] = 'True'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.create_user_home_dir'] = 'True'
default['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.create_user_home_dir_cmd'] = ['mkhomedir_helper']
default['jupyterhub']['config']['jupyterhub_config']['Spawner.cmd'] = 'jupyterhub-singleuser'
default['jupyterhub']['config']['jupyterhub_config']['Spawner.notebook_dir'] = '~/jupyterhub'
default['jupyterhub']['kernels']['python2']['type'] = 'python'
default['jupyterhub']['kernels']['python2']['install'] = true
default['jupyterhub']['kernels']['python2']['python_version'] = 'python2'
default['jupyterhub']['kernels']['python2']['kernel_name'] = 'python2'
default['jupyterhub']['kernels']['python2']['kernel_displayname'] = 'Python 2'
default['jupyterhub']['kernels']['python2']['pips'] = ['pip', 'setuptools', 'wheel', 'ipykernel']
default['jupyterhub']['kernels']['python3']['type'] = 'python'
default['jupyterhub']['kernels']['python3']['install'] = true
default['jupyterhub']['kernels']['python3']['python_version'] = 'python3'
default['jupyterhub']['kernels']['python3']['kernel_name'] = 'python3'
default['jupyterhub']['kernels']['python3']['kernel_displayname'] = 'Python 3'
default['jupyterhub']['kernels']['python3']['pips'] = ['pip', 'setuptools', 'wheel', 'ipykernel']
default['jupyterhub']['kernels']['anaconda2']['type'] = 'anaconda'
default['jupyterhub']['kernels']['anaconda2']['install'] = true
default['jupyterhub']['kernels']['anaconda2']['python_version'] = '2.7.14'
default['jupyterhub']['kernels']['anaconda2']['kernel_name'] = 'anaconda2'
default['jupyterhub']['kernels']['anaconda2']['kernel_displayname'] = 'Anaconda 2'
default['jupyterhub']['kernels']['anaconda2']['pips'] = ['pip', 'setuptools', 'wheel', 'ipykernel']
default['jupyterhub']['kernels']['anaconda2']['condas'] = []
default['jupyterhub']['kernels']['anaconda3']['type'] = 'anaconda'
default['jupyterhub']['kernels']['anaconda3']['install'] = true
default['jupyterhub']['kernels']['anaconda3']['python_version'] = '3.6.5'
default['jupyterhub']['kernels']['anaconda3']['kernel_name'] = 'anaconda3'
default['jupyterhub']['kernels']['anaconda3']['kernel_displayname'] = 'Anaconda 3'
default['jupyterhub']['kernels']['anaconda3']['pips'] = ['pip', 'setuptools', 'wheel', 'ipykernel']
default['jupyterhub']['kernels']['anaconda3']['condas'] = []

# anaconda attributes
default['anaconda']['version'] = 'Anaconda3-5.1.0'
case node['anaconda']['version']
when 'Anaconda2-5.1.0'
  default['anaconda']['source']['url'] = 'https://repo.continuum.io/archive/Anaconda2-5.1.0-Linux-x86_64.sh'
  default['anaconda']['source']['checksum'] = '5f26ee92860d1dffdcd20910ff2cf75572c39d2892d365f4e867a611cca2af5b'
when 'Anaconda3-5.1.0'
  default['anaconda']['source']['url'] = 'https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh'
  default['anaconda']['source']['checksum'] = '7e6785caad25e33930bc03fac4994a434a21bc8401817b7efa28f53619fa9c29'
end
default['anaconda']['config']['app_dir'] = '/opt/anaconda'
default['anaconda']['config']['channels']['add'] = ['conda-forge']
default['anaconda']['config']['channels']['remove'] = []
default['anaconda']['python2']['ipykernel']['install'] = false
default['anaconda']['python2']['ipykernel']['python_version'] = '2.7.14'
default['anaconda']['python2']['ipykernel']['kernel_name'] = 'anaconda2'
default['anaconda']['python2']['ipykernel']['kernel_displayname'] = 'Anaconda 2'
default['anaconda']['python2']['ipykernel']['pips'] = ['ipykernel']
default['anaconda']['python2']['ipykernel']['condas'] = []
default['anaconda']['python3']['ipykernel']['install'] = false
default['anaconda']['python3']['ipykernel']['python_version'] = '3.6.5'
default['anaconda']['python3']['ipykernel']['kernel_name'] = 'anaconda3'
default['anaconda']['python3']['ipykernel']['kernel_displayname'] = 'Anaconda 3'
default['anaconda']['python3']['ipykernel']['pips'] = ['ipykernel']
default['anaconda']['python3']['ipykernel']['condas'] = []
