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

####################################
# :install with various combinations
####################################

# nothing specified
php_pear 'Net_Ping'

# channel specified
php_pear 'Net_Portscan' do
  channel 'pear.php.net'
  action :install
end

# version specified
php_pear 'HTTP2' do
  version '1.1.0'
  action :install
end

# channel and version specified
php_pear 'PHPUnit' do
  channel 'pear.php.net'
  version '1.3.2'
  action :install
end

##########
# :upgrade
##########

# manually install an old pear
execute 'install old version of Net_Url' do
  command '/usr/bin/pear install Net_Url-1.0.1 && touch /tmp/pear_net_url'
  not_if '/usr/bin/pear list | grep ^Net_URL[[:space:]].*1.0.1'
  creates '/tmp/pear_net_url'
end

# upgrade to specific version
php_pear 'Net_Url' do
  channel 'pear.php.net'
  version '1.0.15'
  action :upgrade
end

# manually install an old pear
execute 'install old version of Net_Socket' do
  command '/usr/bin/pear install Net_Socket-1.0.1 && touch /tmp/pear_net_socket'
  not_if '/usr/bin/pear list | grep ^Net_Socket[[:space:]].*1.0.1'
  creates '/tmp/pear_net_socket'
end

# upgrade to any version
php_pear 'Net_Socket' do
  channel 'pear.php.net'
  action :upgrade
end

##########
# :remove
##########

# manually install a random pear
execute 'install Date' do
  command '/usr/bin/pear install Date && touch /tmp/pear_date'
  not_if '/usr/bin/pear list | grep ^Date'
  creates '/tmp/pear_date'
end

# upgrade to any version
php_pear 'Date' do
  action :remove
end
