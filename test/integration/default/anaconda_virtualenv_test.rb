# InSpec test for recipe jupyterhub-chef::anaconda_virtualenv

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

control 'jupyterhub-chef::anaconda_virtualenv' do
  title 'Testing anaconda kernels'

  describe bash('/opt/anaconda/current/bin/conda env list') do
    its('stdout') { should match /anaconda2/ }
    its('exit_status') { should eq 0 }
  end

  describe bash('/opt/anaconda/current/bin/conda env list') do
    its('stdout') { should match /anaconda3/ }
    its('exit_status') { should eq 0 }
  end
end
