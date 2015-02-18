# comments!

php_runtime 'default' do
  version node['php']['version']
  action :install
end

php_pear_channel 'pear.horde.org' do
  action :discover
end
