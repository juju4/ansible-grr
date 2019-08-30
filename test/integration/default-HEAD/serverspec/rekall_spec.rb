
require 'serverspec'

# Required by serverspec
set :backend, :exec

#describe file('/usr/local/bin/rekall') do
describe file('/usr/local/share/env-rekall/bin/rekall') do
  it { should exist }
  it { should be_executable }
end

