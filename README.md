# jupyterhub-chef

This cookbook installs [JupyterHub](https://github.com/jupyterhub/jupyterhub) a multi-user Hub which spawns, manages, and proxies multiple instances of the single-user [Jupyter](http://jupyter.org/) notebook server.

### Prerequsites

By default `Python2` and `Python34` are installed from system package repos. A different Python package, or additional pips, can be specified for installation by overriding the following attributes.

```ruby
# python
node['python']['python2']['install'] = true
node['python']['python2']['package'] = 'python-devel'
node['python']['python2']['pips'] = [ 'pip', 'setuptools', 'wheel', 'virtualenv', 'jupyter', 'py4j', 'ipyparallel' ]
node['python']['python3']['install'] = true
node['python']['python3']['package'] = 'python34-devel'
node['python']['python3']['pips'] = [ 'pip', 'setuptools', 'wheel', 'virtualenv', 'jupyter', 'py4j', 'ipyparallel' ]
```

The current `6.x` version of `NodeJS` is installed by default. A different version of NodeJS, or additional npms, can be specified for installation by overriding the following attributes.

```ruby
# node
node['node']['version'] = '6.x'
node['node']['npms'] = []
node['node']['global_npms'] = [ 'npm', 'configurable-http-proxy' ]
```

### Configuration

By default this cookbook installs JupyterHub version `0.8.1`, which at the time of this writing, is the current version. Various changes can be made to JupyterHub's configuration by overriding the following attributes.

```ruby
# jupyterhub
node['jupyterhub']['install_from'] = 'git'
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

### Kernels

The IPython kernel is the Python execution backend for Jupyter/JupyterHub. This cookbook includes 4 kernels by default, they are as follows:

- python2: kernel running native python `2.7`
- python3: kernel running native python `3.4`
- anaconda2: kernel running python `2.7.14` and default anaconda packages
- anaconda3: kernel running python `3.6.5` and default anaconda packages

These kernels can be enabled/disabled as desired. The name, python version, and included pips can also be changed by modifying the following attributes.

```ruby
# python2 kernel
node['python']['python2']['ipykernel']['install'] = true
node['python']['python2']['ipykernel']['kernel_name'] = 'python2'
node['python']['python2']['ipykernel']['kernel_displayname'] = 'Python 2'
node['python']['python2']['ipykernel']['python_version'] = 'python2'
node['python']['python2']['ipykernel']['pips'] = ['ipykernel']

# python3 kernel
node['python']['python3']['ipykernel']['install'] = true
node['python']['python3']['ipykernel']['kernel_name'] = 'python3'
node['python']['python3']['ipykernel']['kernel_displayname'] = 'Python 3'
node['python']['python3']['ipykernel']['python_version'] = 'python3'
node['python']['python3']['ipykernel']['pips'] = ['ipykernel']

# anaconda2 kernel
node['anaconda']['python2']['ipykernel']['install'] = true
node['anaconda']['python2']['ipykernel']['kernel_name'] = 'anaconda2'
node['anaconda']['python2']['ipykernel']['kernel_displayname'] = 'Anaconda 2'
node['anaconda']['python2']['ipykernel']['python_version'] = '2.7.14'
node['anaconda']['python2']['ipykernel']['pips'] = ['ipykernel']
node['anaconda']['python2']['ipykernel']['condas'] = []

# anaconda3 kernel
node['anaconda']['python3']['ipykernel']['install'] = true
node['anaconda']['python3']['ipykernel']['kernel_name'] = 'anaconda3'
node['anaconda']['python3']['ipykernel']['kernel_displayname'] = 'Anaconda 3'
node['anaconda']['python3']['ipykernel']['python_version'] = '3.6.5'
node['anaconda']['python3']['ipykernel']['pips'] = ['ipykernel']
node['anaconda']['python3']['ipykernel']['condas'] = []
```

To create your own custom user kernel with a pinned version of python and specific included packages run the following from your user shell. Replace `python-custom` with the desired name of your kernel.

```bash
# custom kernel
conda create -n python-custom python=3.6.5 anaconda -y
conda activate python-custom
python -m pip install ipykernel matplotlib pandas scikit-learn tensorflow
python -m ipykernel install --user --name python-custom --display-name python-custom
conda deactivate
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
