require 'serverspec'

set :backend, :exec

puts "os: #{os}"

def pear_bin
  '/usr/bin/pear'
end

def pear_cmd
  "#{pear_bin} list-channels"
end

describe command(pear_cmd) do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^pear.horde.org/) }
end
