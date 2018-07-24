# # encoding: utf-8

# Inspec test for recipe jupyterhub-chef::python_ipykernel

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::python_ipykernel' do
  title 'Testing pyhton ipykernel'

  describe bash('jupyter kernelspec list') do
    its('stdout') { should match /python2/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('jupyter kernelspec list') do
    its('stdout') { should match /python3/ }
    its('exit_status') { should eq 0 }
  end
end
