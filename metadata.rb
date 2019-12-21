name 'jupyterhub-chef'
maintainer 'Ryan Hansohn'
maintainer_email 'info@imnorobot.com'
license 'MIT'
description 'Installs/Configures jupyterhub-chef'
version '3.0.0'
chef_version '>= 12.14'
source_url 'https://github.com/hansohn/jupyterhub-chef'
issues_url 'https://github.com/hansohn/jupyterhub-chef/issues'

supports 'centos', '>= 7.0'

depends 'alternatives'
depends 'python-chef'
