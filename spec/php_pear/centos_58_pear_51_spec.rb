require 'spec_helper'

describe 'php_pear_test::default' do
  cached(:centos_58_pear_51) do
    ChefSpec::ServerRunner.new(
      platform: 'centos',
      version: '5.8',
      step_into: 'php_pear'
      ) do |node|
      node.set['php']['version'] = '5.1'
    end.converge('php_pear_test::default')
  end

  context 'compiling the test recipe' do
    it 'creates php_pear[XML_RPC]' do
      expect(centos_58_pear_51).to install_php_pear('XML_RPC')
    end
  end
end
