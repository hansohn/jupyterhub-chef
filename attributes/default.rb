# node attributes
default['nodejs'] = {
  'version' => '6.x',
  'npms' => %w(),
  'global_npms' => %w(
    npm
    configurable-http-proxy
  ),
}

# python attributes
default['python'] = {
  'python2' => {
    'packages' => %w(
      python-devel
      python2-pip
      python-setuptools
    ),
    'bin' => '/bin/python2',
    'pip_bin' => '/bin/pip2',
    'pips' => %w(),
  },
  'python3' => {
    'packages' => %w(
      python3-devel
      python3-pip
      python3-setuptools
    ),
    'bin' => '/bin/python3.6',
    'pip_bin' => '/bin/pip3.6',
    'pips' => %w(
      'notebook<6'
      jupyter
      py4j
      ipyparallel
    ),
    'symlinks' => {},
  },
  'virtualenvs' => {
    'python2' => {
      'dest_dir' => '/opt/python/virtualenv/python2',
      'python' => '/bin/python2',
      'pips' => %w(
        boto3
        csvkit
        ipykernel
        Keras
        nose
        nose-parameterized
        pandas
        pyGPs
        requests
        tensorflow
        Theano
      ),
    },
    'python3' => {
      'dest_dir' => '/opt/python/virtualenv/python3',
      'python' => '/bin/python3.6',
      'pips' => %w(
        boto3
        csvkit
        ipykernel
        Keras
        nose
        nose-parameterized
        pandas
        pyGPs
        requests
        tensorflow
        Theano
      ),
    },
  },
}

# jupyter
default['jupyter'] = {
  'setup' => {
    'allow_parallel_computing' => true,
    'enable_contrib_nbextensions' => true,
  },
  'kernels' => {
    'python2' => {
      'displayname' => 'Python 2',
      'install' => true,
      'python_dist' => 'python_env',
      'python_env' => 'python2',
    },
    'python3' => {
      'displayname' => 'Python 3',
      'install' => true,
      'python_dist' => 'python_env',
      'python_env' => 'python3',
    },
    'anaconda2' => {
      'displayname' => 'Anaconda 2',
      'install' => true,
      'python_dist' => 'anaconda_env',
      'python_env' => 'anaconda2',
    },
    'anaconda3' => {
      'displayname' => 'Anaconda 3',
      'install' => true,
      'python_dist' => 'anaconda_env',
      'python_env' => 'anaconda3',
    },
  },
}

# jupyterhub attributes
default['jupyterhub'] = {
  'install_from' => 'python',
  'install_version' => '0.9.6',
  'git' => {
    'repo' => 'https://github.com/jupyterhub/jupyterhub',
  },
  'addons' => {
    'packages' => %w(
      blas
      blas-devel
      boost-devel
      gflags-devel
      glog-devel
      hdf5-devel
      leveldb-devel
      lmdb-devel
      opencv-devel
      protobuf-devel
      snappy-devel
    ),
    'pips' => %w(
      ipyparallel
      jupyter_contrib_nbextensions
      jupyter_nbextensions_configurator
      jupyterhub-ldap-authenticator
    ),
    'condas' => %w(),
    'nbextensions' => %w(
      ipyparallel
    ),
    'serverextensions' => %w(
      ipyparallel
    ),
  },
  'group' => {
    'name' => 'jupyterhub',
    'gid' => 10000,
  },
  'user' => {
    'name' => 'jupyterhub',
    'uid' => 15000,
    'home' => '/home/jupyterhub',
    'shell' => '/bin/bash',
  },
  'db' => {
    'type' => 'sqlite',
    'user' => 'jupyterhub_db_user',
    'pass' => 'jupyterhub_db_pass',
    'host' => 'jupyterhub_db_server',
    'port' => '5432',
    'name' => 'jupyterhub_db_name',
  },
  'setup' => {
    'run_as' => 'root',
    'pid_file' => '/var/run/jupyter.pid',
    'app_dir' => '/opt/jupyterhub',
    'runtime_dir' => '/srv/jupyterhub',
    'log_dir' => '/var/log/jupyterhub',
    'enable_ssl' => false,
    'enable_ldap' => false,
  },
  'config' => {
    'jupyterhub_config' => {
      'JupyterHub.ip' => '',
      'JupyterHub.port' => '8000',
      'JupyterHub.ssl_port' => '8443',
      'JupyterHub.hub_ip' => '127.0.0.1',
      'JupyterHub.hub_port' => '8081',
      'JupyterHub.proxy_api_ip' => '127.0.0.1',
      'JupyterHub.proxy_api_port' => '8001',
      'JupyterHub.ssl_cert' => '/etc/ssl/certs/jupyterhub.crt',
      'JupyterHub.ssl_key' => '/etc/ssl/private/jupyterhub.key',
      'Authenticator.whitelist' => %w(),
      'Authenticator.admin_users' => %w(),
      'JupyterHub.authenticator_class' => 'jupyterhub.auth.PAMAuthenticator',
      'JupyterHub.authenticator_ldap_class' => 'ldapauthenticator.LDAPAuthenticator',
      'LDAPAuthenticator.server_hosts' => %w(ldap://ldapserver-1.example.com:389 ldap://ldapserver-2.example.com:389),
      'LDAPAuthenticator.bind_user_dn' => 'uid=ldapquery,cn=users,cn=accounts,dc=example,dc=com',
      'LDAPAuthenticator.bind_user_password' => 'password',
      'LDAPAuthenticator.user_search_base' => 'cn=users,cn=accounts,dc=example,dc=com',
      'LDAPAuthenticator.user_search_filter' => '(&(objectClass=person)(uid={username}))',
      'LDAPAuthenticator.user_membership_attribute' => 'memberOf',
      'LDAPAuthenticator.group_search_base' => 'cn=groups,cn=accounts,dc=example,dc=com',
      'LDAPAuthenticator.group_search_filter' => '(&(objectClass=ipausergroup)(memberOf={group}))',
      'LDAPAuthenticator.allowed_groups' => %w(cn=jupyterhub-users,cn=groups,cn=accounts,dc=example,dc=com),
      'LDAPAuthenticator.allow_nested_groups' => 'True',
      'LDAPAuthenticator.create_user_home_dir' => 'True',
      'LDAPAuthenticator.create_user_home_dir_cmd' => %w(mkhomedir_helper),
      'Spawner.cmd' => 'jupyterhub-singleuser',
      'Spawner.args' => '--NotebookApp.allow_remote_access=True',
      'Spawner.notebook_dir' => '~/jupyterhub',
    },
  },
}

# anaconda attributes
default['anaconda'] = {
  'version' => 'Anaconda3-2019.10',
  'source' => {
    'Anaconda2-5.1.0' => {
      'url' => 'https://repo.continuum.io/archive/Anaconda2-5.1.0-Linux-x86_64.sh',
      'checksum' => '5f26ee92860d1dffdcd20910ff2cf75572c39d2892d365f4e867a611cca2af5b',
    },
    'Anaconda2-5.2.0' => {
      'url' => 'https://repo.continuum.io/archive/Anaconda2-5.2.0-Linux-x86_64.sh',
      'checksum' => 'cb0d7a08b0e2cec4372033d3269979b4e72e2353ffd1444f57cb38bc9621219f',
    },
    'Anaconda3-5.1.0' => {
      'url' => 'https://repo.continuum.io/archive/Anaconda3-5.1.0-Linux-x86_64.sh',
      'checksum' => '7e6785caad25e33930bc03fac4994a434a21bc8401817b7efa28f53619fa9c29',
    },
    'Anaconda3-5.2.0' => {
      'url' => 'https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh',
      'checksum' => '09f53738b0cd3bb96f5b1bac488e5528df9906be2480fe61df40e0e0d19e3d48',
    },
    'Anaconda3-2018.12' => {
      'url' => 'https://repo.continuum.io/archive/Anaconda3-2018.12-Linux-x86_64.sh',
      'checksum' => '1019d0857e5865f8a6861eaf15bfe535b87e92b72ce4f531000dc672be7fce00',
    },
    'Anaconda3-2019.10' => {
      'url' => 'https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh',
      'checksum' => '46d762284d252e51cd58a8ca6c8adc9da2eadc82c342927b2f66ed011d1d8b53',
    },
  },
  'config' => {
    'app_dir' => '/opt/anaconda',
    'channels' => {
      'add' => %w(conda-forge),
      'remove' => %w(),
    },
  },
  'virtualenvs' => {
    'anaconda2' => {
      'python' => '2.7.15',
      'condas' => %w(
        numpy
        pandas
      ),
      'pips' => %w(
        ipykernel
      ),
    },
    'anaconda3' => {
      'python_version' => '3.6.5',
      'condas' => %w(
        numpy
        pandas
      ),
      'pips' => %w(
        ipykernel
      ),
    },
  },
}
