# jupyterhub-chef

[![Build Status](https://travis-ci.org/hansohn/jupyterhub-chef.svg?branch=master)](https://travis-ci.org/hansohn/jupyterhub-chef) [![GitHub tag](https://img.shields.io/github/tag/hansohn/jupyterhub-chef.svg)](https://github.com/hansohn/jupyterhub-chef)

This cookbook installs [JupyterHub](https://github.com/jupyterhub/jupyterhub) a multi-user Hub which spawns, manages, and proxies multiple instances of the single-user [Jupyter](http://jupyter.org/) notebook server.

### Prerequsites

By default `Python2` and `Python34` are installed from system package repos. A different Python package, or additional pips, can be specified for installation by overriding the following attributes.

```ruby
# python
node['python']['python2']['install'] = true
node['python']['python2']['package'] = 'python-devel'
node['python']['python2']['pips'] = ['pip', 'setuptools', 'wheel', 'virtualenv', 'jupyter', 'py4j', 'ipyparallel']
node['python']['python3']['install'] = true
node['python']['python3']['package'] = 'python34-devel'
node['python']['python3']['pips'] = ['pip', 'setuptools', 'wheel', 'virtualenv', 'jupyter', 'py4j', 'ipyparallel']
```

The current `6.x` version of `NodeJS` is installed by default. A different version of NodeJS, or additional npms, can be specified for installation by overriding the following attributes.

```ruby
# node
node['node']['version'] = '6.x'
node['node']['npms'] = []
node['node']['global_npms'] = ['npm', 'configurable-http-proxy']
```

### Configuration

By default this cookbook installs JupyterHub version `0.8.1`, which at the time of this writing, is the current version. Various changes can be made to JupyterHub's configuration by overriding the following attributes.

```ruby
# jupyterhub
node['jupyterhub']['install_from'] = 'python'
node['jupyterhub']['install_version'] = '0.8.1'
node['jupyterhub']['config']['run_as'] = 'root'
node['jupyterhub']['config']['pid_file'] = '/var/run/jupyter.pid'
node['jupyterhub']['config']['app_dir'] = '/opt/jupyterhub'
node['jupyterhub']['config']['runtime_dir'] = '/srv/jupyterhub'
node['jupyterhub']['config']['log_dir'] = '/var/log/jupyterhub'
node['jupyterhub']['config']['allow_parallel_computing'] = true
node['jupyterhub']['config']['enable_ssl'] = false
node['jupyterhub']['config']['enable_ldap'] = false
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ip'] = ''
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.port'] = '8000'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ssl_port'] = '8443'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.hub_ip'] = '127.0.0.1'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.hub_port'] = '8081'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.proxy_api_ip'] = '127.0.0.1'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.proxy_api_port'] = '8001'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ssl_cert'] = '/etc/ssl/certs/jupyterhub.crt'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ssl_key'] = '/etc/ssl/private/jupyterhub.key'
node['jupyterhub']['config']['jupyterhub_config']['Authenticator.whitelist'] = []
node['jupyterhub']['config']['jupyterhub_config']['Authenticator.admin_users'] = []
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.authenticator_class'] = 'jupyterhub.auth.PAMAuthenticator'
node['jupyterhub']['config']['jupyterhub_config']['Spawner.cmd'] = 'jupyterhub-singleuser'
node['jupyterhub']['config']['jupyterhub_config']['Spawner.notebook_dir'] = '~/notebooks'
```

### Permissions

All system users with login rights will be allowed to log into JupyterHub. This scope can be narrowed by modifying the following attributes.

```ruby
# permissions
node['jupyterhub']['config']['jupyterhub_config']['Authenticator.whitelist'] = []
node['jupyterhub']['config']['jupyterhub_config']['Authenticator.admin_users'] = []
```

### LDAP Authentication

LDAP Authentication is not provided in Jupyterhub out of the box. This functionality is provided by the [jupyterhub-ldap-authenticator](https://github.com/hansohn/jupyterhub-ldap-authenticator) package which is installed by default with this cookbook. To utilize this package and enable LDAP Authentication, define the following keys in your attributes file.

```ruby
# enable ldap
node['jupyterhub']['config']['enable_ldap'] = true
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.authenticator_ldap_class'] = 'ldapauthenticator.LDAPAuthenticator'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.server_hosts'] = ['ldaps://ldap1.example.com:636', 'ldaps://ldap2.example.com:636']
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.bind_user_dn'] = 'uid=imauser,cn=users,cn=accounts,dc=example,dc=com'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.bind_user_password'] = 'imapassword'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.user_search_base'] = 'cn=users,cn=accounts,dc=example,dc=com'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.user_search_filter'] = '(&(objectClass=person)(uid={username}))'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.user_membership_attribute'] = 'memberOf'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.group_search_base'] = 'cn=groups,cn=accounts,dc=example,dc=com'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.group_search_filter'] = '(&(objectClass=ipausergroup)(memberOf={group}))'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.allowed_groups'] = ['cn=jupyterhub-users,cn=groups,cn=accounts,dc=example,dc=com']
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.allow_nested_groups'] = 'True'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.create_user_home_dir'] = 'True'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.create_user_home_dir_cmd'] = ['mkhomedir_helper']
```

### PostgreSQL Database

By default Jupyterhub uses a [SQLite](https://www.sqlite.org/index.html) database. To use [PostgreSQL](https://www.postgresql.org/) instead, configure your postgresql server and then add the following keys to your attribute file. Replace values with those associated to your specific instance.

```ruby
node['jupyterhub']['db']['type'] = 'postgresql'
node['jupyterhub']['db']['user'] = 'jupyterhub_db_user'
node['jupyterhub']['db']['pass'] = 'jupyterhub_db_pass'
node['jupyterhub']['db']['host'] = 'jupyterhub_db_server'
node['jupyterhub']['db']['port'] = '5432'
node['jupyterhub']['db']['name'] = 'jupyterhub_db_name'
```

### Kernels

The [IPython](https://ipython.org/) kernel is the Python execution backend for Jupyter/JupyterHub. This cookbook includes 4 kernels by default, they are as follows:

- python2: kernel running native python `2.7`
- python3: kernel running native python `3.4`
- anaconda2: kernel running python `2.7.14` and default anaconda packages
- anaconda3: kernel running python `3.6.5` and default anaconda packages

These kernels can be enabled/disabled as desired. The kernel name, python version, and included pips/condas can also be changed by modifying the following attributes.

```ruby
# python2 kernel
node['jupyterhub']['kernels']['python2']['type'] = 'python'
node['jupyterhub']['kernels']['python2']['install'] = true
node['jupyterhub']['kernels']['python2']['kernel_name'] = 'python2'
node['jupyterhub']['kernels']['python2']['kernel_displayname'] = 'Python 2'
node['jupyterhub']['kernels']['python2']['python_version'] = 'python2'
node['jupyterhub']['kernels']['python2']['pips'] = ['ipykernel']

# python3 kernel
node['jupyterhub']['kernels']['python3']['type'] = 'python'
node['jupyterhub']['kernels']['python3']['install'] = true
node['jupyterhub']['kernels']['python3']['kernel_name'] = 'python3'
node['jupyterhub']['kernels']['python3']['kernel_displayname'] = 'Python 3'
node['jupyterhub']['kernels']['python3']['python_version'] = 'python3'
node['jupyterhub']['kernels']['python3']['pips'] = ['ipykernel']

# anaconda2 kernel
node['jupyterhub']['kernels']['anaconda2']['type'] = 'anaconda'
node['jupyterhub']['kernels']['anaconda2']['install'] = true
node['jupyterhub']['kernels']['anaconda2']['kernel_name'] = 'anaconda2'
node['jupyterhub']['kernels']['anaconda2']['kernel_displayname'] = 'Anaconda 2'
node['jupyterhub']['kernels']['anaconda2']['python_version'] = '2.7.14'
node['jupyterhub']['kernels']['anaconda2']['pips'] = ['ipykernel']
node['jupyterhub']['kernels']['anaconda2']['condas'] = []

# anaconda3 kernel
node['jupyterhub']['kernels']['anaconda3']['type'] = 'anaconda'
node['jupyterhub']['kernels']['anaconda3']['install'] = true
node['jupyterhub']['kernels']['anaconda3']['kernel_name'] = 'anaconda3'
node['jupyterhub']['kernels']['anaconda3']['kernel_displayname'] = 'Anaconda 3'
node['jupyterhub']['kernels']['anaconda3']['python_version'] = '3.6.5'
node['jupyterhub']['kernels']['anaconda3']['pips'] = ['ipykernel']
node['jupyterhub']['kernels']['anaconda3']['condas'] = []
```

To create your own custom kernel with a pinned version of python and specific included packages include the following in your attributes file. Replace `python-custom` with the desired name of your kernel.

```ruby
# custom anaconda kernel
node['jupyterhub']['kernels']['python-custom']['type'] = 'anaconda'
node['jupyterhub']['kernels']['python-custom']['install'] = true
node['jupyterhub']['kernels']['python-custom']['kernel_name'] = 'python-custom'
node['jupyterhub']['kernels']['python-custom']['kernel_displayname'] = 'Python Custom'
node['jupyterhub']['kernels']['python-custom']['python_version'] = '3.6.5'
node['jupyterhub']['kernels']['python-custom']['pips'] = ['ipykernel', 'matplotlib', 'pandas', 'scikit-learn', 'tensorflow']
node['jupyterhub']['kernels']['python-custom']['condas'] = []
```

### Usage

Once installed JupyterHub is available at http://127.0.0.1:8000 unless otherwise modified using the attributes referenced above. Before a user can log into JupyterHub he/she must create their notebooks directory at `~/jupyterhub`. Failure to create this directory will result in 500 errors when logging in.

### Documentation

The following resources may be helpful to better understand JupyterHub usage:

- [JupyterHub Website](https://github.com/jupyterhub/jupyterhub)
- [JupyterHub Documentation](https://jupyterhub.readthedocs.io/en/latest/)
- [Jupyter Website](https://jupyter.org/)
- [Jupyter Documentation](https://jupyter.readthedocs.io/en/latest/)
- [Anaconda Website](https://www.continuum.io/)
- [Anaconda Documentation](https://docs.continuum.io/anaconda/)
- [Anaconda Package List](https://docs.continuum.io/anaconda/pkg-docs)
