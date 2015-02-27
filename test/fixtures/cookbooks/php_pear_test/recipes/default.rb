# comments!

php_runtime 'default' do
  version node['php']['version']
  action :install
end

php_pear_channel 'pear.horde.org' do
  action :discover
end

php_pear 'XML_RPC' do
  action :install
end

# php_pear 'pear/HTTP2' do
#   action :install
# end

# php_pear 'horde/Horde_Thrift' do
#   action :install
# end
