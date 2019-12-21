# encoding: utf-8

# Inspec test for recipe jupyterhub-chef::python_python2

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'jupyterhub-chef::python_python2' do
  title 'Testing python2 installation'

  describe package('python-devel') do
    it { should be_installed }
  end
end
