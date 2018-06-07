# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased](unreleased)

- no new features in development at this time

## [2.0.0](https://github.com/hansohn/jupyterhub-chef/compare/1.0.0...2.0.0) (Jun 07, 2018)

BREAKING CHANGES:

- implement 'instal_from' and 'install_version' attributes to select how to install jupyterhub and which version to install

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
