# # encoding: utf-8

# Inspec test for recipe jupyterhub-chef::nodejs

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::nodejs' do
  title 'Testing nodejs installation'

  describe package('nodejs') do
    it { should be_installed }
  end

  describe bash('npm list -g') do
    its('stdout') { should match /configurable-http-proxy/ }
    its('exit_status') { should eq 0 }
  end
end
