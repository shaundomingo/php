# comments!

php_runtime 'default' do
  version node['php']['version']
  provider Chef::Provider::PhpRuntime::Source
  action :install
end
