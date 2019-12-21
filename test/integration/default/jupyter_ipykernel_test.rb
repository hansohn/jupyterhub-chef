# InSpec test for recipe jupyterhub-chef::jupyter_ipykernel

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

control 'jupyterhub-chef::jupyter_ipykernel' do
  title 'Testing jupyterhub kernels'

  describe bash('/usr/local/bin/jupyter kernelspec list') do
    its('stdout') { should match /python2/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('/usr/local/bin/jupyter kernelspec list') do
    its('stdout') { should match /python3/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('/usr/local/bin/jupyter kernelspec list') do
    its('stdout') { should match /anaconda2/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('/usr/local/bin/jupyter kernelspec list') do
    its('stdout') { should match /anaconda3/ }
    its('exit_status') { should eq 0 }
  end
end
