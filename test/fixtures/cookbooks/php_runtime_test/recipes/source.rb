# comments!

php_runtime 'test runtime 5.6.4' do
  version '5.6.4'
  provider Chef::Provider::PhpRuntime::Source
  action :install
end

php_runtime 'test runtime 5.5.20' do
  version '5.5.20'
  provider Chef::Provider::PhpRuntime::Source
  action :install
end
