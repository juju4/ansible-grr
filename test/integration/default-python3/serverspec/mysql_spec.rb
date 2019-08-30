
require 'serverspec'

# Required by serverspec
set :backend, :exec

### only valid if mysql datastore

#describe service('mysql'), :if => os[:family] == 'ubuntu' do
##  it { should be_enabled }
#  it { should be_running }
#end
#
#describe service('mariadb'), :if => os[:family] == 'redhat' do
#  it { should be_enabled }
#  it { should be_running }
#end

