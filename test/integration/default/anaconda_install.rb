# # encoding: utf-8

# Inspec test for recipe jupyterhub-chef::anaconda_install

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::anaconda_install' do
  title 'Testing anaconda installation'

  describe file('/opt/anaconda') do
    it { should be_directory }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/opt/anaconda/downloads') do
    it { should be_directory }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/opt/anaconda/downloads/Anaconda3-5.1.0-Linux-x86_64.sh') do
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/opt/anaconda/Anaconda3-5.1.0') do
    it { should be_directory }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
  end

  describe file('/opt/anaconda/current') do
    it { should be_symlink }
  end

  describe file('/etc/profile.d/conda.sh') do
    it { should be_symlink }
  end
end
