require 'serverspec'

set :backend, :exec

puts "os: #{os}"

def php_bin
  '/usr/bin/php'
end

def php_cmd
  "#{php_bin} --version"
end

describe command(php_cmd) do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/PHP 5.1/) }
end
