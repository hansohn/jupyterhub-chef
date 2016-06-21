$LOAD_PATH << '../lib'
require 'busser/rubygems'
Busser::RubyGems.install_gem('yarjuf', '>= 2.0.0')

require 'serverspec'
require 'yarjuf'

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: 'windows'
end

RSpec.configure do |c|
  c.path = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin'
  c.output_stream = File.open('/tmp/serverspec-result.xml', 'w')
  c.formatter = 'JUnit'
end
