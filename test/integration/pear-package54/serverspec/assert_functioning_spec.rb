require 'serverspec'

set :backend, :exec

puts "os: #{os}"

def pear_bin
  '/usr/bin/pear'
end

def pear_cmd
  "#{pear_bin} list"
end

describe command(pear_cmd) do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^Net_Ping/) }
  its(:stdout) { should match(/^Net_Portscan/) }
  its(:stdout) { should match(/^HTTP2\s*1\.1\.0/) }
  its(:stdout) { should match(/^PHPUnit\s*1\.3\.2/) }
  its(:stdout) { should match(/^Net_URL\s*1\.0\.15/) }
  its(:stdout) { should match(/^Net_Socket\s*1\.0\.14/) }
end
