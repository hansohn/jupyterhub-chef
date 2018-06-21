# # encoding: utf-8

# Inspec test for recipe jupyterhub-chef::jupyterhub_install

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::jupyterhub_install' do
  title 'Testing jupyterhub installation'

  describe file('/opt/jupyterhub') do
    it { should be_directory }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe bash('python3 -m pip list') do
    its('stdout') { should match /jupyterhub/ }
    its('exit_status') { should eq 0 }
  end
end
