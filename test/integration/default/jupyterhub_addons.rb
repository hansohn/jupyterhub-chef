# encoding: utf-8

# Inspec test for recipe jupyterhub-chef::jupyterhub_addons

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::jupyterhub_addons' do
  title 'Testing jupyterhub extensions'

  describe bash('python3 -m pip list') do
    its('stdout') { should match /ipyparallel/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('/usr/local/bin/jupyter nbextension list') do
    its('stdout') { should match /ipyparallel/ }
    its('exit_status') { should eq 0 }
  end
end
