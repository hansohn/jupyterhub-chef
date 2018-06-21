# # encoding: utf-8

# Inspec test for recipe jupyterhub-chef::jupyterhub_config

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::jupyterhub_config' do
  title 'Testing jupyterhub configuration'

  describe file('/var/log/jupyterhub') do
    it { should be_directory }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/srv/jupyterhub') do
    it { should be_directory }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/srv/jupyterhub/jupyterhub_cookie_secret') do
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0600' }
  end

  describe file('/srv/jupyterhub/jupyterhub_config.py') do
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/etc/skel/jupyterhub') do
    it { should be_directory }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end
end
