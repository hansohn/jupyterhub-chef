# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased](unreleased)

- no new features in development at this time

## [3.0.0](https://github.com/hansohn/jupyterhub-chef/compare/2.3.0...3.0.0) (Jan 03, 2020)

FEATURES:

- update jupyterhub to 0.9.6
- update attribute structure
- update anaconda to Anaconda3-2019.10 

## [2.3.0](https://github.com/hansohn/jupyterhub-chef/compare/2.2.0...2.3.0) (Oct 25, 2018)

FEATURES:

- update python to 3.6
- update jupyterhub to 0.9.4

## [2.2.0](https://github.com/hansohn/jupyterhub-chef/compare/2.1.0...2.2.0) (Jul 23, 2018)

FEATURES:

- update license
- bump anaconda version to Anaconda3-5.2.0
- bump anaconda2 kernel to python 2.7.15

BUG FIXES:

- resolve issue where anaconda version attribute is not intrepreted correctly when defined externally

## [2.1.0](https://github.com/hansohn/jupyterhub-chef/compare/2.0.0...2.1.0) (Jun 20, 2018)

FEATURES:

- remove default recipe functionality
- allow any version of jupyterhub to be installed via python or git
- add inspec tests
- add travis ci

## [2.0.0](https://github.com/hansohn/jupyterhub-chef/compare/1.0.0...2.0.0) (Jun 07, 2018)

BREAKING CHANGES:

- implement 'install_from' and 'install_version' attributes to select how to install jupyterhub and which version to install

FEATURES:

- bump default jupyterhub version to 0.8.1
- support jupyterhub installation from python or github. set python as default
- add jupyterhub config parameters for LDAP integration
- add jupyterhub config parameters for PostgreSQL integration
- add Anaconda kernels to jupyterhub by default

BUG FIXES:

- remove 'c.LocalAuthenticator.create_system_users' parameter in config. Doesn't work with our Auth Class

## [1.0.0](https://github.com/hansohn/jupyterhub-chef/compare/0.1.1...1.0.0) (Feb 17, 2017)

BREAKING CHANGES:

- restructure attributes

FEATURES:

- download node directly instead of using nvm
- upgrade default node version to current 6.x

## [0.1.1](https://github.com/hansohn/jupyterhub-chef/compare/0.1.0...0.1.1) (Jun 20, 2016)

BUG FIXES:

- fix initial commit git issue

## [0.1.0](https://github.com/hansohn/jupyterhub-chef/compare/0.1.0...0.1.0) (Jun 20, 2016)

FEATURES:

- initial commit
