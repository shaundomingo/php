require 'serverspec'

set :backend, :exec

puts "os: #{os}"

def php_bin_1
  '/opt/php-instance-1/bin/php'
end

def php_cmd_1
  "#{php_bin_1} --version"
end

describe command(php_cmd_1) do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/PHP 5.6.4/) }
end

def php_bin_2
  '/opt/php-instance-2/bin/php'
end

def php_cmd_2
  "#{php_bin_2} --version"
end

describe command(php_cmd_2) do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/PHP 5.5.20/) }
end
