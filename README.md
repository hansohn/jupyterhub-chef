# jupyterhub-chef

This cookbook installs [JupyterHub](https://github.com/jupyterhub/jupyterhub) a multi-user Hub which spawns, manages, and proxies multiple instances of the single-user [Jupyter](http://jupyter.org/) notebook server.

### Installation

By default `Python2` and `Python34` are installed from repos included with CentOS. A different version of Python, or additional pips, can be specified for installation by overriding the following attributes.

```ruby
node['python']['python2']['install'] = true
node['python']['python2']['install_method'] = 'package'
node['python']['python2']['package'] = 'python-devel'
node['python']['python2']['pips'] = []
node['python']['python3']['install'] = true
node['python']['python3']['install_method'] = 'package'
node['python']['python3']['package'] = 'python34-devel'
node['python']['python3']['pips'] = []
```

The latest `6.x` version of `NodeJS` is also installed by default. A different version of NodeJS, or additional npms, can be specified for installation by overriding the following attributes.

```ruby
node['node']['version'] = '6.x'
node['node']['npms'] = []
node['node']['global_npms'] = [ 'npm', 'configurable-http-proxy' ]
```

By default JupyterHub binds to `http://127.0.0.1:8000`. This port can be changed, or encryption can be added, by modifying the following attributes.

```ruby
node['jupyterhub']['config']['enable_ssl'] = false
node['jupyterhub']['config']['http_port'] = 8000
node['jupyterhub']['config']['https_port'] = 8443
node['jupyterhub']['config']['jupyterhub_config']['ssl_cert'] = '/etc/ssl/certs/jupyterhub.crt'
node['jupyterhub']['config']['jupyterhub_config']['ssl_key'] = '/etc/ssl/private/jupyterhub.key'
```

All system users with login rights will be allowed to log into JupyterHub. This scope can be narrowed by modifying the following attributes.

```ruby
node['jupyterhub']['config']['jupyterhub_config']['users'] = []
node['jupyterhub']['config']['jupyterhub_config']['admins'] = []
```

### Usage

Once installed JupyterHub is available at `http://127.0.0.1:8000` unless otherwise modified using the attributes referenced above. Before a user can log into JupyterHub he/she must create their notebooks directory at `~/notebooks`. Failure to create this directory will result in 500 errors when logging in.

### Documentation

The following resources may be helpful to better understand JupyterHub usage:

- [JupyterHub Documentation](https://jupyterhub.readthedocs.io/en/latest/)
- [Jupyter Documentation](https://jupyter.readthedocs.io/en/latest/)
