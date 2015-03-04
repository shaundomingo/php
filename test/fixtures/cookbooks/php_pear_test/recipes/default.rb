#
# This recipe exercises the resources that
# ship in the Chef Software php library cookbook.
#

###############################
# Install a php_runtime as a
# prerequisite for installing
# pears.
###############################

php_runtime 'default' do
  version node['php']['version']
  action :install
end

###############################
# randomly selected list from
# http://pear.php.net/channels/
###############################

php_pear_channel 'pear.php.net' do
  action [:discover, :update]
end

php_pear_channel 'pecl.php.net' do
  action [:discover, :update]
end

php_pear_channel 'pear.horde.org' do
  action [:discover, :update]
end

php_pear_channel 'openpear.org' do
  action [:discover, :update]
end

php_pear_channel 'pear.windowsazure.com' do
  action [:discover, :update]
end

#################################
# packages from each of the above
# channels
#################################

# pecl.php.net
# no version specified
php_pear 'DTrace' do
  action :install
end

# pecl.php.net
# version specified
php_pear 'json' do
  version '1.2.1'
  action :install
end

# pear.php.net
# no version specified
php_pear 'HTTP2' do
  channel 'pear.php.net'
  action :install
end

# pear.php.net
# version specified
php_pear 'XML_RPC' do
  version '1.5.5'
  action :install
end

# pear.horde.org
# channel specified
# no version specified
php_pear 'wicked' do
  channel 'pear.horde.org'
  action :install
end

# pear.horde.org
# channel specified
# version specified
php_pear 'horde_lz4' do
  version '1.0.7'
  channel 'pear.horde.org'
  action :install
end
