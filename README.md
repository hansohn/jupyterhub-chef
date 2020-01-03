# jupyterhub-chef

[![Build Status](https://travis-ci.org/hansohn/jupyterhub-chef.svg?branch=master)](https://travis-ci.org/hansohn/jupyterhub-chef) [![GitHub tag](https://img.shields.io/github/tag/hansohn/jupyterhub-chef.svg)](https://github.com/hansohn/jupyterhub-chef)

This cookbook installs [JupyterHub](https://github.com/jupyterhub/jupyterhub) a multi-user Hub which spawns, manages, and proxies multiple instances of the single-user [Jupyter](http://jupyter.org/) notebook server.

### Prerequsites

By default `Python2` and `Python36` are installed from system package repos. A different Python package, or additional pips, can be specified for installation by overriding the following attributes.

```ruby
# python
node['python']['python2']['packages'] = %w(python-devel python2-pip python-setuptools)
node['python']['python2']['bin'] = '/bin/python2'
node['python']['python2']'pip_bin'] = '/bin/pip2'
node['python']['python2']['pips'] = %w()
node['python']['python3']['packages'] = %w(python3-devel python3-pip python3-setuptools)
node['python']['python3']['bin'] = '/bin/python3.6'
node['python']['python3']'pip_bin'] = '/bin/pip3.6'
node['python']['python3']['pips'] = %w('notebook<6' jupyter py4j ipyparallel)
```

The current `6.x` version of `NodeJS` is installed by default. A different version of NodeJS, or additional npms, can be specified for installation by overriding the following attributes.

```ruby
# node
node['nodejs']['version'] = '6.x'
node['nodejs']['npms'] = %w()
node['nodejs']['global_npms'] = %w(npm configurable-http-proxy)
```

### Configuration

By default this cookbook installs JupyterHub version `0.9.4`, which at the time of this writing, is the current version. Various changes can be made to JupyterHub's configuration by overriding the following attributes.

```ruby
# jupyterhub
node['jupyterhub']['install_from'] = 'python'
node['jupyterhub']['install_version'] = '0.9.6'
node['jupyterhub']['setup']['run_as'] = 'root'
node['jupyterhub']['setup']['pid_file'] = '/var/run/jupyter.pid'
node['jupyterhub']['setup']['app_dir'] = '/opt/jupyterhub'
node['jupyterhub']['setup']['runtime_dir'] = '/srv/jupyterhub'
node['jupyterhub']['setup']['log_dir'] = '/var/log/jupyterhub'
node['jupyterhub']['setup']['enable_ssl'] = false
node['jupyterhub']['setup']['enable_ldap'] = false
node['jupyterhub']['config']['jupyterhub_config'][
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ip'] = ''
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.port'] = '8000'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ssl_port'] = '8443'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.hub_ip'] = '127.0.0.1'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.hub_port'] = '8081'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.proxy_api_ip'] = '127.0.0.1'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.proxy_api_port'] = '8001'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ssl_cert'] = '/etc/ssl/certs/jupyterhub.crt'
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.ssl_key'] = '/etc/ssl/private/jupyterhub.key'
node['jupyterhub']['config']['jupyterhub_config']['Authenticator.whitelist'] = %w()
node['jupyterhub']['config']['jupyterhub_config']['Authenticator.admin_users'] = %w()
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.authenticator_class'] = 'jupyterhub.auth.PAMAuthenticator'
node['jupyterhub']['config']['jupyterhub_config']['Spawner.cmd'] = 'jupyterhub-singleuser'
node['jupyterhub']['config']['jupyterhub_config']['Spawner.args'] = '--NotebookApp.allow_remote_access=True'
node['jupyterhub']['config']['jupyterhub_config']['Spawner.notebook_dir'] = '~/jupyterhub'
```

### Permissions

All system users with login rights will be allowed to log into JupyterHub. This scope can be narrowed by modifying the following attributes.

```ruby
# permissions
node['jupyterhub']['config']['jupyterhub_config']['Authenticator.whitelist'] = %w()
node['jupyterhub']['config']['jupyterhub_config']['Authenticator.admin_users'] = %w()
```

### LDAP Authentication

LDAP Authentication is not provided in Jupyterhub out of the box. This functionality is provided by the [jupyterhub-ldap-authenticator](https://github.com/hansohn/jupyterhub-ldap-authenticator) package which is installed by default with this cookbook. To utilize this package and enable LDAP Authentication, define the following keys in your attributes file.

```ruby
# enable ldap
node['jupyterhub']['config']['enable_ldap'] = true
node['jupyterhub']['config']['jupyterhub_config']['JupyterHub.authenticator_ldap_class'] = 'ldapauthenticator.LDAPAuthenticator'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.server_hosts'] = %w(ldaps://ldap1.example.com:636 ldaps://ldap2.example.com:636)
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.bind_user_dn'] = 'uid=imauser,cn=users,cn=accounts,dc=example,dc=com'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.bind_user_password'] = 'imapassword'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.user_search_base'] = 'cn=users,cn=accounts,dc=example,dc=com'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.user_search_filter'] = '(&(objectClass=person)(uid={username}))'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.user_membership_attribute'] = 'memberOf'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.group_search_base'] = 'cn=groups,cn=accounts,dc=example,dc=com'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.group_search_filter'] = '(&(objectClass=ipausergroup)(memberOf={group}))'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.allowed_groups'] = %w(cn=jupyterhub-users,cn=groups,cn=accounts,dc=example,dc=com)
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.allow_nested_groups'] = 'True'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.create_user_home_dir'] = 'True'
node['jupyterhub']['config']['jupyterhub_config']['LDAPAuthenticator.create_user_home_dir_cmd'] = %w(mkhomedir_helper)
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
- python3: kernel running native python `3.6`
- anaconda2: kernel running python `2.7.15` and default anaconda packages
- anaconda3: kernel running python `3.6.5` and default anaconda packages

These kernels can be enabled/disabled as desired. The kernel name, python version, and included pips/condas can also be changed by modifying the following attributes.

```ruby
# python
node['python']['virtualenvs']['python2']['dest_dir'] = '/opt/python/virtualenv/python2'
node['python']['virtualenvs']['python2']['python'] = '/bin/python2'
node['python']['virtualenvs']['python2']['pips'] = %w(boto3 csvkit ipykernel Keras nose nose-parameterized pandas pyGPs requests tensorflow Theano)
node['python']['virtualenvs']['python3']['dest_dir'] = '/opt/python/virtualenv/python3'
node['python']['virtualenvs']['python3']['python'] = '/bin/python3.6'
node['python']['virtualenvs']['python3']['pips'] = %w(boto3 csvkit ipykernel Keras nose nose-parameterized pandas pyGPs requests tensorflow Theano)

# anaconda
node['anaconda']['virtualenvs']['anaconda2']['python'] = '2.7.15'
node['anaconda']['virtualenvs']['anaconda2']['condas'] = %w(numpy pandas)
node['anaconda']['virtualenvs']['anaconda2']['pips'] = %w(ipykernel)
node['anaconda']['virtualenvs']['anaconda3']['python'] = '3.6.5'
node['anaconda']['virtualenvs']['anaconda3']['condas'] = %w(numpy pandas)
node['anaconda']['virtualenvs']['anaconda3']['pips'] = %w(ipykernel)

# jupyter kernels(s)
node['jupyter']['kernels']['python2']['displayname'] = 'Python 2'
node['jupyter']['kernels']['python2']['install'] = true
node['jupyter']['kernels']['python2']['python_dist'] = 'python'
node['jupyter']['kernels']['python2']['python_env'] = 'python2'
node['jupyter']['kernels']['python3']['displayname'] = 'Python 3'
node['jupyter']['kernels']['python3']['install'] = true
node['jupyter']['kernels']['python3']['python_dist'] = 'python'
node['jupyter']['kernels']['python3']['python_env'] = 'python3'
node['jupyter']['kernels']['anaconda2']['displayname'] = 'Anaconda 2'
node['jupyter']['kernels']['anaconda2']['install'] = true
node['jupyter']['kernels']['anaconda2']['python_dist'] = 'anaconda'
node['jupyter']['kernels']['anaconda2']['python_env'] = 'anaconda2'
node['jupyter']['kernels']['anaconda3']['displayname'] = 'Anaconda 3'
node['jupyter']['kernels']['anaconda3']['install'] = true
node['jupyter']['kernels']['anaconda3']['python_dist'] = 'anaconda'
node['jupyter']['kernels']['anaconda3']['python_env'] = 'anaconda3'
```

To create your own custom kernel with a pinned version of python and specific included packages include the following in your attributes file. Replace `python-custom` with the desired name of your kernel.

```ruby
# custom anaconda kernel
node['anaconda']['virtualenvs']['python-custom']['python'] = '3.6.5'
node['anaconda']['virtualenvs']['python-custom']['condas'] = %w(numpy pandas)
node['anaconda']['virtualenvs']['python-custom']['pips'] = %w(ipykernel matplotlib scikit-learn tensorflow)
node['jupyter']['kernels']['python-custom']['displayname'] = 'Python Custom'
node['jupyter']['kernels']['python-custom']['install'] = true
node['jupyter']['kernels']['python-custom']['python_dist'] = 'anaconda'
node['jupyter']['kernels']['python-custom']['python_env'] = 'python-custom'
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
