# comments!

# specify all relevant parameters
php_runtime 'instance-1' do
  version '5.6.5'
  php_home '/opt/php-instance-1'
  mirror_url 'http://us1.php.net/get/php-5.6.5.tar.gz/from/this/mirror'
  source_checksum 'f67c480bcf2f6f703ec8d8a772540f4a518f766b08d634d7a919402c13a636cf'
  provider Chef::Provider::PhpRuntime::Source
  action :install
end

# # commenting out for now to increate test speeds
# # look things up when specifying version number
# php_runtime 'instance-2' do
#   version '5.5.20'
#   provider Chef::Provider::PhpRuntime::Source
#   action :install
# end
