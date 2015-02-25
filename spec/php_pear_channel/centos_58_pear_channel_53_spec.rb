# require 'spec_helper'

# describe 'php_pear_channel_test::default' do
#   cached(:centos_58_pear_channel_53) do
#     ChefSpec::ServerRunner.new(
#       platform: 'centos',
#       version: '5.8',
#       step_into: 'php_pear_channel'
#       ) do |node|
#       node.set['php']['version'] = '5.3'
#     end.converge('php_pear_channel_test::default')
#   end

#   context 'compiling the test recipe' do
#     it 'creates php_pear_channel[default]' do
#       expect(centos_58_pear_channel_53).to install_php_pear_channel('default')
#         .with(version: '5.3')
#     end
#   end

#   context 'stepping into php_pear_channel[default]' do
#     it 'installs package[default :install php-cli]' do
#       expect(centos_58_pear_channel_53).to install_package('default :install php53-cli')
#         .with(package_name: 'php53-cli', version: nil)
#     end

#     it 'installs package[default :install php-common]' do
#       expect(centos_58_pear_channel_53).to install_package('default :install php53-common')
#         .with(package_name: 'php53-common', version: nil)
#     end
#   end
# end
