# # encoding: utf-8

# Inspec test for recipe jupyterhub-chef::anaconda_config

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::anaconda_config' do
  title 'Testing anaconda configuration'

  describe bash('source /etc/profile.d/conda.sh && conda config --show channels') do
    its('stdout') { should match /conda-forge/ }
  end
end
