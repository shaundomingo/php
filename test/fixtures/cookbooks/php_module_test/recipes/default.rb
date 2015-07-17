#
# This recipe exercises the resources that
# ship in the Chef Software php library cookbook.
#

###############################
# Install a php_runtime as a
# prerequisite for installing
# pears.
###############################

Chef::Log.info("php version: #{node['php']['version']}")

php_runtime 'default' do
  version node['php']['version']
  action :install
end

php_module 'mysql' do
  action [:install]
end

php_module 'pgsql' do
  action [:install]
end
