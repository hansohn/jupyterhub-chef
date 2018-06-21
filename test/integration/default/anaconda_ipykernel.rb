# # encoding: utf-8

# Inspec test for recipe jupyterhub-chef::anaconda_ipykernel

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::anaconda_ipykernel' do
  title 'Testing anaconda kernels'

  describe bash('jupyter kernelspec list') do
    its('stdout') { should match /anaconda2/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('jupyter kernelspec list') do
    its('stdout') { should match /anaconda3/ }
    its('exit_status') { should eq 0 }
  end
end
