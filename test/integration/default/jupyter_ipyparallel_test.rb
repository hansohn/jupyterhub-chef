# InSpec test for recipe jupyterhub-chef::jupyter_ipyparallel

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

control 'jupyterhub-chef::jupyter_ipyparallel' do
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
