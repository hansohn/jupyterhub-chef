# # encoding: utf-8

# Inspec test for recipe jupyterhub-chef::python

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

control 'jupyterhub-chef::python' do
  title 'Testing python installation'

  describe package('python-devel') do
    it { should be_installed }
  end

  describe bash('python2 -m pip list') do
    its('stdout') { should match /jupyter/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('python2 -m pip list') do
    its('stdout') { should match /py4j/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('python2 -m pip list') do
    its('stdout') { should match /ipyparallel/ }
    its('exit_status') { should eq 0 }
  end

  describe package('python34-devel') do
    it { should be_installed }
  end

  describe bash('python3 -m pip list') do
    its('stdout') { should match /jupyter/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('python3 -m pip list') do
    its('stdout') { should match /py4j/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('python3 -m pip list') do
    its('stdout') { should match /ipyparallel/ }
    its('exit_status') { should eq 0 }
  end
end
