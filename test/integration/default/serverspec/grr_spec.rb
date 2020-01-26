require 'serverspec'

# Required by serverspec
set :backend, :exec

grr_virtualenv = '/usr/local/share/env-grr'

### debian package
describe file('/usr/bin/grr_server'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_executable }
end
describe file('/usr/bin/grr_config_updater'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_executable }
end
describe file('/etc/grr/server.local.yaml'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  its(:content) { should match /-----BEGIN RSA PRIVATE KEY-----/ }
  its(:content) { should_not match /^AdminUI.django_secret_key: ''/ }
end
describe file('/etc/grr/server2.local.yaml'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  its(:content) { should match /AdminUI.url/ }
end

### pip virtualenv install
describe file("#{grr_virtualenv}/bin/grr_server"), :if => os[:release] != '16.04' do
  it { should be_executable }
end
describe file("#{grr_virtualenv}/bin/grr_config_updater"), :if => os[:release] != '16.04' do
  it { should be_executable }
end
## FIXME! ipython issue
#describe file("#{grr_virtualenv}/install_data/etc/server.local.yaml"), :if => os[:release] != '16.04' do
#  its(:content) { should match /-----BEGIN PRIVATE KEY-----/ }
#end
describe file("#{grr_virtualenv}/install_data/etc/server2.local.yaml"), :if => os[:release] != '16.04' do
  its(:content) { should match /AdminUI.url/ }
end

### Note: only valid after 'grr_config_updater initialize'
describe service('grr-server'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_enabled }
  it { should be_running }
end

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
describe process("grr_server") do

  its(:user) { should eq "root" }

#  it "is listening on port 44449" do
#    expect(port(44449)).to be_listening
#  end
#  it "is listening on port 8000" do
#    expect(port(8000)).to be_listening
#  end
#  it "is listening on port 8080" do
#    expect(port(8080)).to be_listening
#  end

end

## there are some error log messages during installation that prevent those check
#describe file('/var/log/syslog'), :if => os[:family] == 'ubuntu' do
#  it { should exist }
#  its(:content) { should_not match /grr_server.*ERROR/ }
#end
#describe file('/var/log/messages'), :if => os[:family] == 'redhat' do
#  it { should exist }
#  its(:content) { should_not match /grr_server.*ERROR/ }
#end

### only in master
##describe command('/bin/bash run_tests.sh | tee /root/grr-run_tests.log'), :sudo => false do
###  its(:stdout) { should match /bin/ }
##  its(:exit_status) { should eq 0 }
##end

describe command('curl -sSq http://127.0.0.1:8000/server.pem') do
  its(:stdout) { should match /-----BEGIN CERTIFICATE-----/ }
  its(:exit_status) { should eq 0 }
end
describe command('curl -sSq http://127.0.0.1:8000/control') do
  its(:stderr) { should match /Empty reply from server/ }
  its(:exit_status) { should eq 52 }
end
