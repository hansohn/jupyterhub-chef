# encoding: utf-8

# Inspec test for recipe jupyterhub-chef::python_python3

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'jupyterhub-chef::python_python3' do
  title 'Testing python3 installation'

  describe package('python3-devel') do
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
