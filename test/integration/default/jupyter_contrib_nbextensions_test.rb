# InSpec test for recipe jupyterhub-chef::jupyter_contrib_nbextensions

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

control 'jupyterhub-chef::jupyter_contrib_nbextensions' do
  title 'Testing jupyterhub contrib'

  describe bash('python3 -m pip list') do
    its('stdout') { should match /jupyter-contrib-nbextensions/ }
    its('exit_status') { should eq 0 }
  end
end
