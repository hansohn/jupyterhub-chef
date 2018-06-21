# # encoding: utf-8

# Inspec test for recipe jupyterhub-chef::jupyterhub_service

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::jupyterhub_service' do
  title 'Testing jupyterhub service'

  describe service('jupyterhub') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8000) do
    it { should be_listening }
  end
end
