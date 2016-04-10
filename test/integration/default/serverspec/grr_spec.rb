require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('mysqld') do  
#  it { should be_enabled   }
  it { should be_running   }
end  

describe service('grr-dataserver-master') do  
  it { should be_enabled   }
#  it { should be_running   }
end  

describe service('grr-http-server') do  
  it { should be_enabled   }
  it { should be_running   }
end  

describe service('grr-worker') do  
  it { should be_enabled   }
  it { should be_running   }
end  

describe service('grr-dataserver-slave') do  
  it { should be_enabled   }
#  it { should be_running   }
end  

describe service('grr-ui') do  
  it { should be_enabled   }
  it { should be_running   }
end  

describe file('/usr/local/bin/rekall') do
  it { should exist }
end

describe process("grr_server") do

  its(:user) { should eq "root" }

  it "is listening on port 44449" do
    expect(port(44449)).to be_listening
  end
  it "is listening on port 8000" do
    expect(port(8000)).to be_listening
  end
  it "is listening on port 8080" do
    expect(port(8080)).to be_listening
  end

end

## only in master
#describe command('/bin/bash run_tests.sh | tee /root/grr-run_tests.log'), :sudo => false do
##  its(:stdout) { should match /bin/ }
#  its(:exit_status) { should eq 0 }
#end

