# comments!

php_runtime 'default' do
  version node['php']['version']
  action :install
end

###########
# :discover
###########
php_pear_channel 'pear.horde.org' do
  action :discover
end

###########
# :add
###########
cache_path = Chef::Config[:file_cache_path]

remote_file "#{cache_path}/symfony-channel.xml" do
  source "http://pear.symfony-project.com/channel.xml"
  mode '0644'
  action :create
end

php_pear_channel "symfony" do
  channel_xml "#{cache_path}/symfony-channel.xml"
  action :add
end

###########
# :update
###########

###########
# :remove
###########
