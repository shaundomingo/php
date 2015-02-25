# require 'spec_helper'

# describe 'php_pear_channel_test::default' do
#   cached(:centos_70_pear_channel_54) do
#     ChefSpec::ServerRunner.new(
#       platform: 'centos',
#       version: '7.0',
#       step_into: 'php_pear_channel'
#       ) do |node|
#       node.set['php']['version'] = '5.4'
#     end.converge('php_pear_channel_test::default')
#   end

#   context 'compiling the test recipe' do
#     it 'creates php_pear_channel[default]' do
#       expect(centos_70_pear_channel_54).to install_php_pear_channel('default')
#         .with(version: '5.4')
#     end
#   end

#   context 'stepping into php_pear_channel[default]' do
#     it 'installs package[default :install php-cli]' do
#       expect(centos_70_pear_channel_54).to install_package('default :install php-cli')
#         .with(package_name: 'php-cli', version: nil)
#     end

#     it 'installs package[default :install php-common]' do
#       expect(centos_70_pear_channel_54).to install_package('default :install php-common')
#         .with(package_name: 'php-common', version: nil)
#     end
#   end
# end
