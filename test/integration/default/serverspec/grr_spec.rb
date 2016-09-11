require 'serverspec'

# Required by serverspec
set :backend, :exec

### debian package
describe file('/usr/bin/grr_server'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_executable }
end
describe file('/usr/bin/grr_config_updater'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_executable }
end
describe file('/etc/grr/server.local.yaml'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  its(:content) { should match /AdminUI.url/ }
#  its(:content) { should match /-----BEGIN PRIVATE KEY-----/ }
end

### pip virtualenv install
describe file('/root/env-grr//bin/grr_server'), :if => os[:release] != '16.04' do
  it { should be_executable }
end
describe file('/root/env-grr//bin/grr_config_updater'), :if => os[:release] != '16.04' do
  it { should be_executable }
end
describe file('/root/env-grr/install_data/etc/server.local.yaml'), :if => os[:release] != '16.04' do
  its(:content) { should match /AdminUI.url/ }
#  its(:content) { should match /-----BEGIN PRIVATE KEY-----/ }
end


### Note: only valid after 'grr_config_updater initialize'
#describe service('grr-server'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
#  it { should be_enabled }
#  it { should be_running }
#end
#
#describe service('grr-dataserver-master'), :if => os[:family] == 'ubuntu' && os[:release] != '16.04' do
#  it { should be_enabled }
##  it { should be_running }
#end
#
#describe service('grr-http-server'), :if => os[:family] == 'ubuntu' && os[:release] != '16.04'  do
#  it { should be_enabled }
#  it { should be_running }
#end
#
#describe service('grr-worker'), :if => os[:family] == 'ubuntu' && os[:release] != '16.04'  do
#  it { should be_enabled }
#  it { should be_running }
#end
#
#describe service('grr-dataserver-slave'), :if => os[:family] == 'ubuntu' && os[:release] != '16.04'  do
#  it { should be_enabled }
##  it { should be_running }
#end
#
#describe service('grr-ui'), :if => os[:family] == 'ubuntu' && os[:release] != '16.04'  do
#  it { should be_enabled }
#  it { should be_running }
#end
#
#describe process("grr_server") do
#
#  its(:user) { should eq "root" }
#
#  it "is listening on port 44449" do
#    expect(port(44449)).to be_listening
#  end
#  it "is listening on port 8000" do
#    expect(port(8000)).to be_listening
#  end
#  it "is listening on port 8080" do
#    expect(port(8080)).to be_listening
#  end
#
#end
#
#describe file('/var/log/syslog') do
#  it { should exist }
#  its(:content) { should_not match /grr_server.*ERROR/ }
#end
#
### only in master
##describe command('/bin/bash run_tests.sh | tee /root/grr-run_tests.log'), :sudo => false do
###  its(:stdout) { should match /bin/ }
##  its(:exit_status) { should eq 0 }
##end
#
#describe command('curl -sSq http://127.0.0.1:8000/server.pem') do
#  its(:stdout) { should match /-----BEGIN CERTIFICATE-----/ }
#  its(:exit_status) { should eq 0 }
#end
#describe command('curl -sSq http://127.0.0.1:8000/control') do
#  its(:stdout) { should match /Empty reply from server/ }
#  its(:exit_status) { should eq 52 }
#end
#
